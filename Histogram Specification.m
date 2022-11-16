classdef Assignment2_a_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        ApplyhistogramSpecButton  matlab.ui.control.Button
        UplaodRequiredhistogramimageButton  matlab.ui.control.Button
        UplaodOrignalImageButton  matlab.ui.control.Button
        UIAxes2_2                 matlab.ui.control.UIAxes
        UIAxes2                   matlab.ui.control.UIAxes
        UIAxes_4                  matlab.ui.control.UIAxes
        UIAxes_3                  matlab.ui.control.UIAxes
        UIAxes_2                  matlab.ui.control.UIAxes
        UIAxes                    matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: UplaodOrignalImageButton
        function UplaodOrignalImageButtonPushed(app, event)
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            global a;
            a=imread(filename);
            imshow(a,'Parent',app.UIAxes);
            histogram(a,'Parent',app.UIAxes_2);
        end

        % Button pushed function: UplaodRequiredhistogramimageButton
        function UplaodRequiredhistogramimageButtonPushed(app, event)
            [filename2, pathname2] = uigetfile('*.*', 'Pick an Image');
            filename2=strcat(pathname2,filename2);
            global a1; 
            a1=imread(filename2);
            imshow(a1,'Parent',app.UIAxes_3);
            histogram(a1,'Parent',app.UIAxes_4);

        end

        % Button pushed function: ApplyhistogramSpecButton
        function ApplyhistogramSpecButtonPushed(app, event)
  global a;
  global a1; 
            b = size(a);

            % Loop for Getting the Histogram of the image
c=zeros(1,256);
for i=1:b(1)                                        %Reading the rows
    for j=1:b(2)                                    %reading the columns
        for k=0:255                                 %k is pointing the graylevel form 0 to 255
            if a(i,j)==k                            %getting the graylevel of the pixel a(i,j)
                c(k+1)=c(k+1)+1;                    %increasing the frequency of the gray level found at a(i,j)
            end
        end
    end
end
%Generating PDF out of histogram by diving by total no. of pixels
pdf=(1/(b(1)*b(2)))*c;

%Generating CDF out of PDF
cdf = zeros(1,256);
cdf(1)=pdf(1);
for i=2:256
    cdf(i)=cdf(i-1)+pdf(i);
end
cdf = round(255*cdf);


%Repeating the above steps for this image
a1 = rgb2gray(a1);
b1=size(a1);
a1=double(a1);

c1=zeros(1,256);
for i1=1:b1(1)
    for j1=1:b1(2)
        for k1=0:255
            if a1(i1,j1)==k1
                c1(k1+1)=c1(k1+1)+1;
            end
        end
    end
end
pdf1=(1/(b1(1)*b1(2)))*c1;
cdf1 = zeros(1,256);
cdf1(1)=pdf1(1);
for i1=2:256
    cdf1(i1)=cdf1(i1-1)+pdf1(i1);
end

cdf1 = round(255*cdf1);
%Comparing the CDFs of the given and the required images
d = 255*ones(1,256);
for k=1:256
    for k1=1:256
    if cdf(k)<cdf1(k1)
        d(k)=k1;                                   %tranforming function d
        break
    end
    end
end

%Generating the final output of the given image
ep = zeros(b(1),b(2));
for i=1:b(1)
    for j=1:b(2)
        t=(a(i,j)+1);
        ep(i,j)=d(t);
    end
end

%generating Histogram of the output image
c2 = zeros(1,256);
for i1=1:b1(1)
    for j1=1:b1(2)
        for k1=0:255
            if ep(i1,j1)==k1
                c2(k1+1)=c2(k1+1)+1;
            end
        end
    end
end

imshow(uint8(ep),'Parent',app.UIAxes2);
plot(c2,'Parent',app.UIAxes2_2);

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1132 584];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Orignal Image')
            app.UIAxes.Position = [51 395 207 174];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.UIFigure);
            title(app.UIAxes_2, 'Histogram')
            app.UIAxes_2.Position = [267 395 207 174];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.UIFigure);
            title(app.UIAxes_3, 'Required histogram image')
            app.UIAxes_3.Position = [607 404 186 165];

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.UIFigure);
            title(app.UIAxes_4, 'Histogram')
            app.UIAxes_4.Position = [806 404 186 165];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Modified Image')
            app.UIAxes2.Position = [407 35 318 220];

            % Create UIAxes2_2
            app.UIAxes2_2 = uiaxes(app.UIFigure);
            title(app.UIAxes2_2, 'Histogram')
            app.UIAxes2_2.Position = [762 35 300 185];

            % Create UplaodOrignalImageButton
            app.UplaodOrignalImageButton = uibutton(app.UIFigure, 'push');
            app.UplaodOrignalImageButton.ButtonPushedFcn = createCallbackFcn(app, @UplaodOrignalImageButtonPushed, true);
            app.UplaodOrignalImageButton.Position = [194 318 196 59];
            app.UplaodOrignalImageButton.Text = 'Uplaod Orignal Image';

            % Create UplaodRequiredhistogramimageButton
            app.UplaodRequiredhistogramimageButton = uibutton(app.UIFigure, 'push');
            app.UplaodRequiredhistogramimageButton.ButtonPushedFcn = createCallbackFcn(app, @UplaodRequiredhistogramimageButtonPushed, true);
            app.UplaodRequiredhistogramimageButton.Position = [723 346 198 50];
            app.UplaodRequiredhistogramimageButton.Text = 'Uplaod Required histogram image';

            % Create ApplyhistogramSpecButton
            app.ApplyhistogramSpecButton = uibutton(app.UIFigure, 'push');
            app.ApplyhistogramSpecButton.ButtonPushedFcn = createCallbackFcn(app, @ApplyhistogramSpecButtonPushed, true);
            app.ApplyhistogramSpecButton.Position = [100 96 224 63];
            app.ApplyhistogramSpecButton.Text = 'Apply histogram  Spec';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Assignment2_a_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end