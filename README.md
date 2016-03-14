# WGradientProgressDemo
//A easily used gradient progress view

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>README.md</title>
<link rel="stylesheet" href="https://stackedit.io/res-min/themes/base.css" />
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"></script>
</head>
<body><div class="container"><h1 id="overview">OVERVIEW</h1>

<p>WGradientProgress is a gradual color change for <strong>any UIViews</strong>, which is written in Objective-C, <strong>supporting iOS5 ~ iOSlatest</strong></p>

<p>Here are examples for WGradientProgress:</p>

<p><img src="http://media.xtwind.com/images/2016/03/14/8429fdc87fb84c60eea8508d6a1c7440.gif" alt="" title=""></p>
<hr>

<h2 id="installtation">INSTALLTATION</h2>

<p>Drag the </p>

<blockquote>
  <p>WGradientProgress</p>
</blockquote>

<p>folder into your project.</p>

<hr>

<h2 id="requirements">REQUIREMENTS</h2>

<ul>
<li>Xcode 6</li>
<li>iOS5 or above</li>
<li>ARC</li>
</ul>

<hr>



<h2 id="usage">USAGE</h2>

<ol>
<li><p>Add the following import to the top of the file:</p>

<blockquote>
  <p>#import "WGradientProgress.h"</p>
</blockquote></li>
<li><p>Use the following to display or hide progress easily:</p></li>
</ol>

`WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    [gradProg showOnParent:navigationBar position:WProgressPosDown];`

    [gradProg hide];

<h2 id="contact">CONTACT</h2>

<p>Do you have any questions or idea? My email is: </p>

<blockquote>
  <p>zilin_weng@163.com</p>
</blockquote>

<p>Or you can find some more info at my blog in cnblogs.com:</p>

<blockquote>
  <p><a href="http://www.cnblogs.com/wengzilin/">http://www.cnblogs.com/wengzilin/</a></p>
</blockquote>

<hr>

<h2 id="note">NOTE</h2>

<p>This project will be update continually. Therefore, <strong>fork</strong> or <strong>star</strong> would be suggested.</p>

<hr>

<h2 id="license">LICENSE</h2>

<p>THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p></div></body>
</html>
