%takes domainMin = a, domainMax = b i.e. [a,b] and preci accuracy = epsilon
%and evaluates the roots of function at the bottom of this file by bisection method

function bisect (domainMin, domainMax, accuracy)
    [bIsConverging, fDomainMin,fDomainMax] = isConverging(domainMin,domainMax);
    if ~bIsConverging
    	fprintf('function does not converge, f(a) = %f and f(b) = %f\n', fDomainMin, fDomainMax);
        return;
    end
    midPoint =[];
    previousMidPoint =[];
    iteration = 0;
    %format the table out put header
    fprintf('#    a    b    f(a)    f(b)    root\n');

    while ~isPrecise(midPoint, previousMidPoint, accuracy)
        iteration=iteration+1;
        previousMidPoint = midPoint;
        [midPoint, fOfDomainMin, fOfDomainMax, domainMin, domainMax] = tryFindRoot(domainMin ,domainMax);
        fprintf('%d %f %f %f %f %f\n',iteration , domainMin, domainMax, fOfDomainMin, fOfDomainMax, midPoint);

    end
end


function isPrecise= isPrecise(result, previousResult, precision)
    if isempty(result) || isempty(previousResult)
        isPrecise = false;
    elseif (abs(result - previousResult) / abs(result)) < precision
        isPrecise = true;
        
    else
        isPrecise = false;
    end
end
function [bIsConverging, fDomainMin,fDomainMax] = isConverging(domainMin,domainMax)
    fDomainMin = f(domainMin);
    fDomainMax = f(domainMax);
    bIsConverging = fDomainMin * fDomainMax < 0;
end
    

function [midPoint, fOfDomainMin, fOfDomainMax, newDomainMin, newDomainMax] = tryFindRoot(domainMin,domainMax)
 
    midPoint = (domainMin + domainMax) /2;
    fOfDomainMin = f(domainMin);
    fOfDomainMax = f(domainMax);
    fofMidPoint = f(midPoint);
    if fOfDomainMax * fofMidPoint < 0
        newDomainMin = midPoint;
        newDomainMax = domainMax;
    elseif fOfDomainMin * fofMidPoint <0
        newDomainMax = midPoint;
        newDomainMin = domainMin;
    else
       fprintf('function does not converge, f(a) = %f and f(b) = %f\n', fOfDomainMin, fOfDomainMax);
    end
end

function y = f(x)
    y = x.^3 + 4*x.^2 -10;
end

