%takes domainMin = a, domainMax = b i.e. [a,b] and accuracy = epsilon
%and evaluates the roots of function at the bottom of this file by bisection method

function bisect (domainMin, domainMax, accuracy)
    
    %call isconverging to chech if the funciton is converging
    [bIsConverging, fDomainMin,fDomainMax] = isConverging(domainMin,domainMax);
    %if not converging, print error
    if ~bIsConverging
    	fprintf('\n\nfunction does not converge, f(a) = %f and f(b) = %f\n\n', fDomainMin, fDomainMax);
        return;
    end
    %initialize with empty so accuracy isn't effected by some random value;
    midPoint =[];
    previousMidPoint =[];
    
    %iteration counter
    iteration = 0;
    
    %format the table out put header
    fprintf('\n\n%-12s%-15s%-15s%-15s%-15s%-15s\n\n','#','a','b','f(a)','f(b)','root');
    
    %while accuracy of root isn't within provided epsilon, keep on
    %bisecting the function
    while ~isAccurate(midPoint, previousMidPoint, accuracy)
        %iteration count
        iteration=iteration+1;
        %save current mid point to calculate accuracy next time
        previousMidPoint = midPoint;
        
        %call tryFindRoot to get a new root
        [midPoint, fOfDomainMin, fOfDomainMax, newDomainMin, newDomainMax] = tryFindRoot(domainMin ,domainMax);
        
        %print out the new root along with other necessary info
        fprintf('%-7d %-15f %-15f %-15f %-15f %-15f\n',iteration , domainMin, domainMax, fOfDomainMin, fOfDomainMax, midPoint);
      
        %set the function domain to new bisected values
        domainMin = newDomainMin;
        domainMax = newDomainMax;
    end
end

% takes current root, previous root, accuracy = epsilon and tells wehter
% the root is within accurate bounds or not based on (Pn - Pn-1)/Pn <
% epsilon, where Pn is current root and Pn-1 is previous root
function isAccurate= isAccurate(root, previousRoot, accuracy)
    %if current root or previous root are empty then it's the first
    %calculation, need atleast two roots to calculate accuracy.
    if isempty(root) || isempty(previousRoot)
        isAccurate = false;
    elseif (abs(root - previousRoot) / abs(root)) < accuracy
        isAccurate = true;
        
    else
        isAccurate = false;
    end
end

%tells if the funtion is converging
function [bIsConverging, fDomainMin,fDomainMax] = isConverging(domainMin,domainMax)
    fDomainMin = f(domainMin);
    fDomainMax = f(domainMax);
    bIsConverging = fDomainMin * fDomainMax < 0;
end
    
% performs bisections and returns new root and new domain boundries based
% upon the value of f(newRoot)
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


%Function to perform the bisection upon
function y = f(x)
    y = 3*(x+1)*(x-1/2)*(x-1);
end

