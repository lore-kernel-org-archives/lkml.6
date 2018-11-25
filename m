Return-Path: <SRS0=cVYn=OE=charlyeb.com=info@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_RATIO_02,HTML_MESSAGE,SPF_PASS,
	T_REMOTE_IMAGE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A02C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:52:38 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.34 at mail.kernel.org; Sun, 25 Nov 2018 12:52:37 UTC
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=charlyeb.com header.i=@charlyeb.com header.b="InpCAslI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3002084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=charlyeb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=info@charlyeb.com
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net (a2nlsmtp01-02.prod.iad2.secureserver.net [198.71.225.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3002084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:52:37 +0000 (UTC)
Received: from a2plcpnl0071.prod.iad2.secureserver.net ([198.71.227.12])
	by : HOSTING RELAY : with ESMTP
	id QtlegAsE5xtAIQtlegFoSF; Sun, 25 Nov 2018 05:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=charlyeb.com; s=default; h=Content-Type:Date:Subject:Reply-To:To:From:
	Mime-Version:Message-Id:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2L+fRB3UK26v0cVEVeq6sE/a0vzER9/ziBVtrlKAG78=; b=InpCAslI2MzXhDRTO9k3ruNkOn
	vMx10BJbXKkg1TVqisSN6yVpkTKBPB2wTysgcjnkMpUA4SJyCO9p2RZcusy1S04LjH+90p99LxZse
	m/rTVlkSaYinBmc7XSEHF6O9+BQTVWCHDmt88XwCeiqg1wAO/LqSzyNslf9wjc8RHQ7r2hFYK1WGr
	L5aw4X14yqiwOTJAQPf1dk3XDBPOG+2AmDoxhh2UDzTWc/9F1XdogM7obtTbKndvEutg/aIdNTWn2
	SJkdbB4eEDVwrNfNdMBxppMOceXS87PCi8ij8TR/0uDOQReDbet8wXjGp3xNXfqa9zKPoAGdLSEm3
	Q885ZJ8w==;
Received: from 155-186-151-248.dhcp.chtrptr.net ([155.186.151.248]:64409 helo=[192.168.1.111])
	by a2plcpnl0071.prod.iad2.secureserver.net with esmtpa (Exim 4.91)
	(envelope-from <info@charlyeb.com>)
	id 1gQtld-00EtCp-LM
	for linux-kernel@archiver.kernel.org; Sun, 25 Nov 2018 05:44:05 -0700
Message-Id: <64S3EW0F-F1PH-HYJU-7LY6-2BKFVO8QO@charlyeb.com>
Mime-Version: 1.0
From: Nish Johnson <Nis@charlyeb.com>
To: ";https:  lore.kernel.org lkml 20160209131838.GA22486@gmail.com T" <linux-kernel@archiver.kernel.org>
Reply-To: Nish@charlyeb.com
Subject: =?utf-8?Q?[PR]_Treat_yourself_with_this_awesome_=F0=9F=8C=9FCyber_Monday_offer=F0=9F=8C=9F_?=
Date: Sun, 25 Nov 2018 07:44:05 -0500
Content-Type: multipart/alternative; Boundary="--=BOUNDARY_1125744_SAXS_BCAE_HPYG_ICDO"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2plcpnl0071.prod.iad2.secureserver.net
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - charlyeb.com
X-Get-Message-Sender-Via: a2plcpnl0071.prod.iad2.secureserver.net: authenticated_id: nish@charlyeb.com
X-Authenticated-Sender: a2plcpnl0071.prod.iad2.secureserver.net: nish@charlyeb.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfPPU9rRnbc9+s2afu+HDiCozqr25EP1Awvav+0cfljkqrFMR8L5eqSoZa13zwOjAMx8aTW9kMP3z+lCvuynwyL+q+jXQ2iVFQA0fT5mnNWFmu9IVB7qH
 /SUTk984pweqmsc0+VAFNFdJGAfn2gPY57zG9N3g7TS8/gC09gib9QTOQpWxoxIjBQvcqKjI55yyLnM3DW0gWSeCwxl8q/ejvtM7pNPxlnUZGP/aux8+3rBT
List-Id: <linux-kernel.vger.kernel.org>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

----=BOUNDARY_1125744_SAXS_BCAE_HPYG_ICDO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

a { word-break: break-word; } a img { border:none; } img {
outline:none; text-decoration:none; -ms-interpolation-mode: bicubic; }
body { width: 100% !important; -webkit-text-size-adjust: 100%;
-ms-text-size-adjust: 100%; } =2EExternalClass { width: 100%; }
=2EExternalClass, =2EExternalClass p, =2EExternalClass span, =2EExternalCla=
ss
font, =2EExternalClass td, =2EExternalClass div { line-height: 100%; }
#page-wrap { margin: 0; padding: 0; width: 100% !important;
line-height: 100% !important; } #outlook a { padding: 0; } =2Epreheader {
display:none !important; } a[x-apple-data-detectors] { color: inherit
!important; text-decoration: none !important; font-size: inherit
!important; font-family: inherit !important; font-weight: inherit
!important; line-height: inherit !important; } =2Ea5q { display: none
!important; } =2EApple-web-attachment { vertical-align: initial
!important; } =2EApple-edge-to-edge-visual-media { margin: initial
!important; max-width: initial !important; width: 100%; } @media only
screen and (max-width: 580px) { table=2Eemail-body-wrap { width: 320px
!important; } td=2Epage-bg-show-thru { display: none !important; }
table=2Elayout-block-wrapping-table { width: 320px !important; }
table=2Emso-fixed-width-wrapping-table { width: 320px !important; }
=2Elayout-block-full-width { width: 320px !important; }
table=2Elayout-block-column, table=2Elayout-block-padded-column { width:
100% !important; } table=2Elayout-block-box-padding { width: 100%
!important; padding: 5px !important; }
table=2Elayout-block-horizontal-spacer { display: none !important; }
tr=2Elayout-block-vertical-spacer { display: block !important; height:
8px !important; } td=2Econtainer-padding { display: none !important; }
table { min-width: initial !important; } td { min-width: initial
!important; } =2Edesktop-only { display: none !important; } =2Emobile-only
{ display: block !important; } =2Ehide { max-height: none !important;
display: block !important; overflow: visible !important; }
#eqLayoutContainer { } =2EEQ-00 { width: 320px !important; } =2EEQ-01 {
width: 320px !important; height: 56px !important; } =2EEQ-02 { width:
17px !important; } =2EEQ-03 { width: 16px !important; } =2EEQ-04 { width:
287px !important; } =2EEQ-05 { height:9px !important; } /* vertical
spacer */ =2EEQ-06 { width: 17px !important; } =2EEQ-07 { width: 16px
!important; } =2EEQ-08 { width: 287px !important; } =2EEQ-09 { width: 16px
!important; } =2EEQ-0A { width: 16px !important; } =2EEQ-0B { width: 288px
!important; } =2EEQ-0C { height:17px !important; } /* vertical spacer */
=2EEQ-0D { width: 16px !important; } =2EEQ-0E { width: 16px !important; }
=2EEQ-0F { width: 288px !important; } =2EEQ-10 { width: 278px !important;
height: 127px !important; } =2EEQ-11 { width: 52px !important; } =2EEQ-12 {=

width: 47px !important; } =2EEQ-13 { width: 221px !important; } }
table=2Elayout-block-horizontal-spacer { display: none !important; }
table { border-collapse:collapse; mso-table-lspace:0pt;
mso-table-rspace:0pt; mso-table-bspace:0pt; mso-table-tspace:0pt;
mso-padding-alt:0; mso-table-top:0; mso-table-wrap:around; } td {
border-collapse:collapse; mso-cellspacing:0; } 96



&nbsp;





















































&nbsp;



Say Goodbye To Fake Brazilian Hair From China, and Say Hello To
Authentic Indian Hair From India!



&nbsp;



&nbsp;

&nbsp; Say Goodbye To Fake Brazilian Hair From China, and Say Hello To
Authentic Indian Hair From India! &nbsp;

&nbsp;



&nbsp;



Say goodbye to fake Brazilian hair from China, and say Hello to
Authentic Indian Hair from India!



&nbsp;



&nbsp; &nbsp;



&nbsp; &nbsp;



&nbsp;



The Naked Truth!&nbsp;So many of us have been fed the tall tales about
Virgin hair=2E We have heard about Brazilian hair, Malaysian hair,
Peruvian hair, 1-10 A grade etc=2E It=E2=80=99s exhausting trying to remove=
 all
of the labels and understand what you=E2=80=99re buying=2E Charlye B=
=2E Hair takes
all the guess work out of buying virgin hair=2E Because the only thing
that matters is that you=E2=80=99re getting the best extensions your money =
can
buy=2E Charlye Hair is a US base, hair company that offers clean,
healthy, raw Indian temple hair=2E Our hair is imported from South India
where millions of women donate their hair, to temples, for religious
reasons=2E This practice is not a part of any other culture=2E Most hair
comes from India=2E&nbsp;Chinese hair factories purchase Indian waste
hair, and process it with chemicals, and mix it with animal fibers=2E
It's packaged, and labeled as 100% virgin hair, and truthfully, it may
contain only 20% human hair=2E&nbsp; Charlye B is fed up with the
lies!&nbsp;We give you raw 100% Indian hair, that will last for 5
years, with proper care! We offer the best hair your money can buy!



&nbsp;



&nbsp;

&nbsp; The Naked Truth! So many of us have been fed the tall tales
about Virgin hair=2E We have heard about Brazilian hair, Malaysian hair,
Peruvian hair, 1-10 A grade etc=2E It=E2=80=99s exhausting trying to remove=
 all
of the labels and understand what you=E2=80=99re buying=2E Charlye B=
=2E Hair takes
all the guess work out of buying virgin hair=2E Because the only thing
that matters is that you=E2=80=99re getting the best extensions your money =
can
buy=2E Charlye Hair is a US base, hair company that offers clean,
healthy, raw Indian temple hair=2E Our hair is imported from South India
where millions of women donate their hair, to temples, for religious
reasons=2E This practice is not a part of any other culture=2E Most hair
comes from India=2E Chinese hair factories purchase Indian waste hair,
and process it with chemicals, and mix it with animal fibers=2E It's
packaged, and labeled as 100% virgin hair, and truthfully, it may
contain only 20% human hair=2E  Charlye B is fed up with the lies! We
give you raw 100% Indian hair, that will last for 5 years, with proper
care! We offer the best hair your money can buy!&nbsp;

&nbsp;



&nbsp; &nbsp;



&nbsp; &nbsp;



&nbsp;



&nbsp;



&nbsp;



&nbsp;















































&nbsp;



Nish C=2E Johnson | Vendor Relations | O: 646=2E844=2E2953&nbsp;One World
Trade Center: 285 Fulton St, Suite 8500 Manhattan, NY 10007 website -
Instagram&nbsp;



&nbsp;



&nbsp;

&nbsp; Nish C=2E Johnson | Vendor Relations | O: 646=2E844=2E2953 One World=

Trade Center: 285 Fulton St, Suite 8500 Manhattan, NY 10007 website -
Instagram &nbsp;

&nbsp;

&nbsp;

----=BOUNDARY_1125744_SAXS_BCAE_HPYG_ICDO
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<HTML xmlns=3D"http://www=2Ew3=2Eorg/1999/xhtml" xmlns:v=3D"urn:schemas-mic=
rosoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:office"><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
	<meta name=3D"Generator" content=3D"Created with TOWER ONE Mail Designer">=

	<meta name=3D"Viewport" content=3D"width=3Ddevice-width, initial-scale=
=3D1=2E0">
	<style type=3D"text/css" id=3D"Mail Designer General Style Sheet">
		a { word-break: break-word; }
		a img { border:none; }
		img { outline:none; text-decoration:none; -ms-interpolation-mode: bicubic=
; }
		body { width: 100% !important; -webkit-text-size-adjust: 100%; -ms-text-s=
ize-adjust: 100%; }
		=2EExternalClass { width: 100%; }
		=2EExternalClass, =2EExternalClass p, =2EExternalClass span, =2EExternalC=
lass font, =2EExternalClass td, =2EExternalClass div { line-height: 100%; }=

		#page-wrap { margin: 0; padding: 0; width: 100% !important; line-height: =
100% !important; }
		#outlook a { padding: 0; }
		=2Epreheader { display:none !important; }
		a[x-apple-data-detectors] { color: inherit !important; text-decoration: n=
one !important; font-size: inherit !important; font-family: inherit !import=
ant; font-weight: inherit !important; line-height: inherit !important; }
		=2Ea5q { display: none !important; }
		=2EApple-web-attachment { vertical-align: initial !important; }
		=2EApple-edge-to-edge-visual-media { margin: initial !important; max-widt=
h: initial !important; width: 100%; }
	</style>
	<style type=3D"text/css" id=3D"Mail Designer Mobile Style Sheet">
		@media only screen and (max-width: 580px) {
			table=2Eemail-body-wrap {
				width: 320px !important;
			}
			td=2Epage-bg-show-thru {
				display: none !important;
			}
			table=2Elayout-block-wrapping-table {
				width: 320px !important;
			}
			table=2Emso-fixed-width-wrapping-table {
				width: 320px !important;
			}
			=2Elayout-block-full-width {
				width: 320px !important;
			}
			table=2Elayout-block-column, table=2Elayout-block-padded-column {
				width: 100% !important;
			}
			table=2Elayout-block-box-padding {
				width: 100% !important;
				padding: 5px !important;
			}
			table=2Elayout-block-horizontal-spacer {
				display: none !important;
			}
			tr=2Elayout-block-vertical-spacer {
			   display: block !important;
			   height: 8px !important;
			}
			td=2Econtainer-padding {
				display: none !important;
			}
		=09
			table {
				min-width: initial !important;
			}
			td {
				min-width: initial !important;
			}
		=09
			=2Edesktop-only { display: none !important; }
			=2Emobile-only { display: block !important; }
		=09
			=2Ehide {
				max-height: none !important;
				display: block !important;
				overflow: visible !important;
			}
		=09
			#eqLayoutContainer {
			}
		=09
			=2EEQ-00 { width: 320px !important; }
			=2EEQ-01 { width: 320px !important; height: 56px !important; }
		=09
			=2EEQ-02 { width: 17px !important; }
			=2EEQ-03 { width: 16px !important; }
			=2EEQ-04 { width: 287px !important; }
			=2EEQ-05 { height:9px !important; } /* vertical spacer */
		=09
			=2EEQ-06 { width: 17px !important; }
			=2EEQ-07 { width: 16px !important; }
			=2EEQ-08 { width: 287px !important; }
		=09
			=2EEQ-09 { width: 16px !important; }
			=2EEQ-0A { width: 16px !important; }
			=2EEQ-0B { width: 288px !important; }
			=2EEQ-0C { height:17px !important; } /* vertical spacer */
		=09
			=2EEQ-0D { width: 16px !important; }
			=2EEQ-0E { width: 16px !important; }
			=2EEQ-0F { width: 288px !important; }
			=2EEQ-10 { width: 278px !important; height: 127px !important; }
		=09
			=2EEQ-11 { width: 52px !important; }
			=2EEQ-12 { width: 47px !important; }
			=2EEQ-13 { width: 221px !important; }
		}
	</style>
	<!--[if gte mso 9]>
	<style type=3D"text/css" id=3D"Mail Designer Outlook Style Sheet">
		table=2Elayout-block-horizontal-spacer {
		    display: none !important;
		}
		table {
		    border-collapse:collapse;
		    mso-table-lspace:0pt;
		    mso-table-rspace:0pt;
		    mso-table-bspace:0pt;
		    mso-table-tspace:0pt;
		    mso-padding-alt:0;
		    mso-table-top:0;
		    mso-table-wrap:around;
		}
		td {
		    border-collapse:collapse;
		    mso-cellspacing:0;
		}
	</style>
	<xml>
		<o:OfficeDocumentSettings>
			<o:AllowPNG/>
			<o:PixelsPerInch>96</o:PixelsPerInch>
		</o:OfficeDocumentSettings>
	</xml>
	<![endif]-->


<link href=3D"https://fonts=2Egoogleapis=2Ecom/css?family=3DRaleway:700,reg=
ular" rel=3D"stylesheet" type=3D"text/css" class=3D"EQWebFont"><meta http-e=
quiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8"></head>
<body style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; marg=
in-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; pa=
dding-left: 0px; " background=3D"page-bg=2Ejpg"><!--[if gte mso 9]>
<v:background xmlns:v=3D"urn:schemas-microsoft-com:vml" fill=3D"t">
<v:fill type=3D"tile" src=3D"page-bg=2Ejpg" />
</v:background>
<![endif]-->
=20

<table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" id=3D"page-wrap" =
align=3D"center" background=3D"page-bg=2Ejpg">
<tbody>
<tr>
	<td>

<table class=3D"email-body-wrap" width=3D"810" cellspacing=3D"0" cellpaddin=
g=3D"0" id=3D"email-body" align=3D"center">
<tbody>
<tr>
	<td width=3D"30" class=3D"page-bg-show-thru">&nbsp;<!--Left page bg show-t=
hru -->
</td>
	<td width=3D"750" id=3D"page-body" background=3D"page-bg=2Ejpg" bgcolor=
=3D"#ffffff">
	=09
		<!--Begin of layout container -->
		<div id=3D"eqLayoutContainer">
		=09
			<div width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"750">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width" width=3D"750">
								<tbody>
<tr>
									<td width=3D"750">
										<div class=3D"layout-block-image">
											<img width=3D"750" height=3D"131" alt=3D"" src=3D"http://chuckad=
amsphotos=2Ecom/emarketingcb/image-3=2Epng" border=3D"0" style=3D"line-heig=
ht: 1px; display: block; width: 750px; height: 131px; " class=3D"EQ-01">
									=09
</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table width=3D"750" cellspacing=
=3D"0" cellpadding=3D"0" class=3D"mso-fixed-width-wrapping-table">
<tr><td valign=3D"top" class=3D"layout-block-full-width"><div class=3D"layo=
ut-block-image"><img height=3D"131" alt=3D"" src=3D"image-3=2Epng" border=
=3D"0" style=3D"line-height: 1px; display: block;"  class=3D"img-EQMST-3CDF=
3BAC-8532-4AB4-84B7-1547E41632D6" width=3D"750"></img><div style=3D"width:0=
px;height:0px;max-height:0;max-width:0;overflow:hidden;display:none;visibil=
ity:hidden;mso-hide:all;"></div></div></td>
</tr></table><![endif]--></div>
		=09
			<div width=3D"100%" class=3D"desktop-only">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"750">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width" width=3D"750">
								<tbody>
<tr>
									<td width=3D"750">
										<div class=3D"layout-block-image">
											<a href=3D"https://www=2Echarlyeb=2Ecom"><img width=3D"750" heig=
ht=3D"431" alt=3D"https://www=2Echarlyeb=2Ecom" src=3D"http://chuckadamspho=
tos=2Ecom/emarketingcb/image-1=2Ejpg" border=3D"0" style=3D"line-height: 1p=
x; display: block; width: 750px; height: 431px; "></a>
									=09
</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table width=3D"750" cellspacing=
=3D"0" cellpadding=3D"0" class=3D"mso-fixed-width-wrapping-table">
<tr><td valign=3D"top" class=3D"layout-block-full-width"><div class=3D"layo=
ut-block-image"><a href=3D"https://www=2Echarlyeb=2Ecom"><img height=
=3D"431" alt=3D"https://www=2Echarlyeb=2Ecom" src=3D"image-1=2Ejpg" border=
=3D"0" style=3D"line-height: 1px; display: block;" class=3D"img-EQMST-A3DFE=
C46-51FA-451A-ACDD-D6ABFF7CCE7F" width=3D"750"></img><div style=3D"width:0p=
x;height:0px;max-height:0;max-width:0;overflow:hidden;display:none;visibili=
ty:hidden;mso-hide:all;"></div></a></div></td>
</tr></table><![endif]--></div>
		=09
			<!--[if !mso ]><!-->
		=09
			<div width=3D"100%" class=3D"mobile-only hide" style=3D"display: none; m=
ax-height: 0px; overflow: hidden; ">
				<table width=3D"320" cellspacing=3D"0" cellpadding=3D"0" class=3D"layou=
t-block-wrapping-table hide" style=3D"display: none; max-height: 0px; overf=
low: hidden; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"320">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width hide" width=3D"320" style=3D"display: none; max-height: 0px; overfl=
ow: hidden; ">
								<tbody>
<tr>
									<td width=3D"320">
										<div class=3D"layout-block-image hide" style=3D"display: none; ma=
x-height: 0px; overflow: hidden; ">
											<a href=3D"https://www=2Echarlyeb=2Ecom"><img width=3D"320" heig=
ht=3D"257" alt=3D"" src=3D"http://chuckadamsphotos=2Ecom/emarketingcb/image=
-17=2Epng" border=3D"0" style=3D"line-height: 1px; display: none; max-heigh=
t: 0px; overflow: hidden; width: 320px; height: 257px; " class=3D"hide"></a=
>
										</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			</div><!--<![endif]-->
		=09
			<div width=3D"100%" class=3D"desktop-only">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"750">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width" width=3D"750">
								<tbody>
<tr>
									<td width=3D"750">
										<div class=3D"layout-block-image">
											<img width=3D"750" height=3D"41" alt=3D"" src=3D"http://chuckada=
msphotos=2Ecom/emarketingcb/image-4=2Epng" border=3D"0" style=3D"line-heigh=
t: 1px; display: block; width: 750px; height: 41px; ">
									=09
</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table width=3D"750" cellspacing=
=3D"0" cellpadding=3D"0" class=3D"mso-fixed-width-wrapping-table">
<tr><td valign=3D"top" class=3D"layout-block-full-width"><div class=3D"layo=
ut-block-image"><img height=3D"41" alt=3D"" src=3D"image-4=2Epng" border=
=3D"0" style=3D"line-height: 1px; display: block;" class=3D"img-EQMST-A1665=
9F1-63EE-448C-8746-71B41D590310" width=3D"750"></img><div style=3D"width:0p=
x;height:0px;max-height:0;max-width:0;overflow:hidden;display:none;visibili=
ty:hidden;mso-hide:all;"></div></div></td>
</tr></table><![endif]--></div>
		=09
			<!--[if !mso ]><!-->
		=09
			<div width=3D"100%" class=3D"mobile-only hide" style=3D"display: none; m=
ax-height: 0px; overflow: hidden; ">
				<table width=3D"320" cellspacing=3D"0" cellpadding=3D"0" class=3D"layou=
t-block-wrapping-table hide" style=3D"display: none; max-height: 0px; overf=
low: hidden; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"320">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width hide" width=3D"320" style=3D"display: none; max-height: 0px; overfl=
ow: hidden; ">
								<tbody>
<tr>
									<td width=3D"320">
										<div class=3D"layout-block-image hide" style=3D"display: none; ma=
x-height: 0px; overflow: hidden; ">
											<img width=3D"320" height=3D"41" alt=3D"" src=3D"http://chuckada=
msphotos=2Ecom/emarketingcb/image-18=2Epng" border=3D"0" style=3D"line-heig=
ht: 1px; display: none; max-height: 0px; overflow: hidden; width: 320px; he=
ight: 41px; " class=3D"hide">
										</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			</div><!--<![endif]-->
		=09
			<div width=3D"100%" class=3D"desktop-only" style=3D"background-image:url=
(box-bg=2Ejpg); background-position: 0% 0%; ">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"box-bg=2Ejpg" b=
gcolor=3D"#ebebeb" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td width=3D"45">&nbsp;</td>
						<td valign=3D"top" align=3D"left" width=3D"668">
							<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-column">
								<tbody>
<tr>
									<td width=3D"648" valign=3D"top" align=3D"left" background=3D"box-=
bg=2Ejpg" style=3D"padding-left: 10px; padding-right: 10px; " bgcolor=
=3D"#ebebeb">
										<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-=
box-padding">
											<tbody>
<tr>
												<td align=3D"left" class=3D"layout-block-column" width=3D"648">=

													<div class=3D"heading" style=3D"font-size: 26px; font-family: =
Raleway, 'Avenir Next', Avenir, Arial; color: rgb(0, 0, 0); font-style: nor=
mal; font-weight: normal; line-height: 30px; text-align: center; text-decor=
ation: none; ">
														Say Goodbye To Fake Brazilian Hair From China, and Say Hello =
To Authentic Indian Hair From India!
													</div>
												</td>
											</tr>
										</tbody>
</table>
									</td>
								</tr>
							</tbody>
</table>
						</td>
						<td width=3D"37">&nbsp;</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"45" class=3D"layout-block-padding-left" bgcolor=3D"#ebebeb=
">&nbsp; </td><td width=3D"668" class=3D"layout-block-content-cell" valign=
=3D"top" align=3D"left"><v:rect style=3D"width:668px;" stroke=3D"f"><v:fill=
 type=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fill><v:textbox s=
tyle=3D"mso-fit-shape-to-text:true" inset=3D"0,0,0,0"><div><div style=
=3D"font-size:0"><table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout=
-block-box-padding">
<tr><td style=3D"font-size:1px;" width=3D"10">&nbsp; </td><td align=3D"left=
" class=3D"layout-block-column" width=3D"648"><div class=3D"text" style=
=3D"font-size: 26px; font-family: Arial; color: rgb(0, 0, 0); font-style: n=
ormal; font-weight: normal; line-height: 30px; text-align: center; text-dec=
oration: none;">
														Say Goodbye To Fake Brazilian Hair From China, and Say Hello =
To Authentic Indian Hair From India!
													</div></td><td style=3D"font-size:1px;" width=3D"10">&nbsp; </=
td>
</tr></table></div></div></v:textbox></v:rect></td><td width=3D"37" class=
=3D"layout-block-padding-right" bgcolor=3D"#ebebeb">&nbsp; </td>
</tr></table><![endif]--></div>
		=09
			<!--[if !mso ]><!-->
		=09
			<div width=3D"100%" class=3D"mobile-only hide" style=3D"display: none; m=
ax-height: 0px; overflow: hidden; ">
				<table width=3D"320" cellspacing=3D"0" cellpadding=3D"0" class=3D"layou=
t-block-wrapping-table hide" style=3D"display: none; max-height: 0px; overf=
low: hidden; ">
					<tbody>
<tr>
						<td width=3D"10">&nbsp;</td>
						<td valign=3D"top" align=3D"left" width=3D"292">
							<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-column hide" width=3D"292" style=3D"display: none; max-hei=
ght: 0px; overflow: hidden; ">
								<tbody>
<tr>
									<td width=3D"272" valign=3D"top" align=3D"left" background=3D"box-=
bg-3=2Ejpg" style=3D"padding-left: 10px; padding-right: 10px; " bgcolor=
=3D"#ffffff">
										<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-=
box-padding hide" width=3D"272" style=3D"display: none; max-height: 0px; ov=
erflow: hidden; ">
											<tbody>
<tr>
												<td align=3D"left" class=3D"layout-block-column" width=3D"272">=

													<div class=3D"heading" style=3D"font-size: 17px; font-family: =
Raleway, 'Avenir Next', Avenir, Arial; text-align: left; color: rgb(0, 0, 0=
); font-style: normal; font-weight: normal; line-height: 30px; text-decorat=
ion: none; ">
														Say goodbye to fake Brazilian hair from China, and say Hello =
to Authentic Indian Hair from India!
													</div>
												</td>
											</tr>
										</tbody>
</table>
									</td>
								</tr>
							</tbody>
</table>
						</td>
						<td width=3D"18">&nbsp;</td>
					</tr>
				</tbody>
</table>
			</div><!--<![endif]-->
		=09
			<div style=3D"background-image:url(box-bg=2Ejpg); background-position: 0=
% 0%; " width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"box-bg=2Ejpg" b=
gcolor=3D"#ebebeb" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td width=3D"40" class=3D"EQ-02" style=3D"font-size:1px; ">&nbsp;</td=
>
						<td height=3D"20" background=3D"box-bg=2Ejpg" class=3D"EQ-04" width=
=3D"673" bgcolor=3D"#e6e6e6">

							<div class=3D"spacer">
						</div>

</td>
						<td width=3D"37" class=3D"EQ-03" style=3D"font-size:1px; ">&nbsp;</td=
>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"40" class=3D"layout-block-padding-left" style=3D"font-size=
:0"><v:rect style=3D"width:40px;height:20px;" stroke=3D"f"><v:fill type=
=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fill>&nbsp; </v:rect><=
/td><td class=3D"layout-block-content-cell" style=3D"font-size:0;" width=
=3D"673" height=3D"20"><v:rect style=3D"width:673px;height:20px;" stroke=
=3D"f"><v:fill type=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fil=
l><div class=3D"spacer"></div></v:rect></td><td width=3D"37" class=3D"layou=
t-block-padding-right" style=3D"font-size:0"><v:rect style=3D"width:37px;he=
ight:20px;" stroke=3D"f"><v:fill type=3D"tile" src=3D"box-bg=2Ejpg" color=
=3D"#ebebeb"></v:fill>&nbsp; </v:rect></td>
</tr></table><![endif]--></div>
		=09
			<div style=3D"background-image:url(box-bg=2Ejpg); background-position: l=
eft top; " width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"box-bg=2Ejpg" b=
gcolor=3D"#e6e6e6" style=3D"mso-hide:all; ">
					<tbody><tr>
						<td width=3D"40" class=3D"EQ-06">&nbsp;</td>
						<td width=3D"673" class=3D"EQ-08">
							<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-column">
								<tbody><tr>
									<td width=3D"653" valign=3D"top" align=3D"left" background=3D"box-=
bg=2Ejpg" style=3D"padding-left: 10px; padding-right: 10px; " bgcolor=
=3D"#e6e6e6">
										<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-=
box-padding">
											<tbody><tr>
												<td align=3D"left" class=3D"layout-block-column" width=3D"653">=

													<div class=3D"text" style=3D"font-size: 16px; font-family: 'Lu=
cida Grande'; line-height: 1=2E5; "><font face=3D"Arial" style=3D"line-heig=
ht: 1=2E5; "><b style=3D"font-family: Raleway, &quot;Avenir Next&quot;, Ave=
nir, Arial; font-size: 26px; ">The Naked Truth!&nbsp;</b></font><div style=
=3D"line-height: 1=2E5; "><font face=3D"Arial" style=3D"line-height: 1=
=2E5; "><span style=3D"font-family: Raleway, &quot;Avenir Next&quot;, Aveni=
r, Arial; font-size: 15px; ">So many of us have been fed the tall tales abo=
ut Virgin hair=2E We have heard about Brazilian hair, Malaysian hair, Peruv=
ian hair, 1-10 A grade etc=2E It=E2=80=99s exhausting trying to remove all =
of the labels and understand what you=E2=80=99re buying=2E Charlye B=
=2E Hair takes all the guess work out of buying virgin hair=2E Because the =
only thing that matters is that you=E2=80=99re getting the best extensions =
your money can buy=2E</span></font><div><font face=3D"Raleway, Avenir Next,=
 Avenir, Arial"><span style=3D"font-size: 15px; "><br></span></font><div st=
yle=3D"line-height: 1=2E5; "><font face=3D"Arial" style=3D"font-size: 16px;=
 "><span style=3D"font-family: Raleway, &quot;Avenir Next&quot;, Avenir, Ar=
ial; font-size: 15px; ">Charlye Hair is a US base, hair company that offers=
 clean, healthy, raw Indian temple hair=2E Our hair is imported from South =
India where millions of women donate their hair, to temples, for religious =
reasons=2E This practice is not a part of any other culture=2E Most hair co=
mes from India=2E&nbsp;</span></font><span style=3D"font-family: Raleway, &=
quot;Avenir Next&quot;, Avenir, Arial; font-size: 15px; ">Chinese hair fact=
ories purchase Indian waste hair, and process it with chemicals, and mix it=
 with animal fibers=2E It's packaged, and labeled as 100% virgin hair, and =
truthfully, it may  contain only 20%  human hair=2E&nbsp;</span></div><div =
style=3D"line-height: 1=2E5; "><font face=3D"Arial" style=3D"font-size: 16p=
x; "><span style=3D"font-family: Raleway, &quot;Avenir Next&quot;, Avenir, =
Arial; font-size: 15px; "><br></span></font></div><div style=3D"line-height=
: 1=2E5; "><font face=3D"Arial"><span style=3D"font-family: Raleway, &quot;=
Avenir Next&quot;, Avenir, Arial; font-size: 26px; "><b>Charlye B is fed up=
 with the lies!&nbsp;</b></span></font></div><div style=3D"line-height: 1=
=2E5; "><font face=3D"Arial" style=3D"font-size: 16px; "><span style=
=3D"font-family: Raleway, &quot;Avenir Next&quot;, Avenir, Arial; font-size=
: 15px; ">We give you raw 100% Indian hair, that will  last for 5 years, wi=
th proper care! We offer the best hair your money can buy!</span></font></d=
iv></div></div></div>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
							</tbody></table>
						</td>
						<td width=3D"37" class=3D"EQ-07">&nbsp;</td>
					</tr>
				</tbody></table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"40" class=3D"layout-block-padding-left" bgcolor=3D"#ebebeb=
">&nbsp; </td><td width=3D"673" class=3D"layout-block-content-cell" valign=
=3D"top" align=3D"left"><v:rect style=3D"width:673px;" stroke=3D"f"><v:fill=
 type=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fill><v:textbox s=
tyle=3D"mso-fit-shape-to-text:true" inset=3D"0,0,0,0"><div><div style=
=3D"font-size:0"><table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout=
-block-box-padding">
<tr><td style=3D"font-size:1px;" width=3D"10">&nbsp; </td><td align=3D"left=
" class=3D"layout-block-column" width=3D"653"><div class=3D"text" style=
=3D"font-size: 16px; font-family: sans-serif; line-height: 150%;"><font fac=
e=3D"Arial" style=3D"line-height: 150%;"><b style=3D"font-family: Arial; fo=
nt-size: 26px;">The Naked Truth!=C2=A0</b></font><div style=3D"line-height:=
 150%;"><font face=3D"Arial" style=3D"line-height: 150%;"><span style=
=3D"font-family: Arial; font-size: 15px;">So many of us have been fed the t=
all tales about Virgin hair=2E We have heard about Brazilian hair, Malaysia=
n hair, Peruvian hair, 1-10 A grade etc=2E It=E2=80=99s exhausting trying t=
o remove all of the labels and understand what you=E2=80=99re buying=
=2E Charlye B=2E Hair takes all the guess work out of buying virgin hair=
=2E Because the only thing that matters is that you=E2=80=99re getting the =
best extensions your money can buy=2E</span></font><div><font face=3D"Arial=
"><span style=3D"font-size: 15px;"><br></span></font><div style=3D"line-hei=
ght: 150%;"><font face=3D"Arial" style=3D"font-size: 16px;"><span style=
=3D"font-family: Arial; font-size: 15px;">Charlye Hair is a US base, hair c=
ompany that offers clean, healthy, raw Indian temple hair=2E Our hair is im=
ported from South India where millions of women donate their hair, to templ=
es, for religious reasons=2E This practice is not a part of any other cultu=
re=2E Most hair comes from India=2E=C2=A0</span></font><span style=3D"font-=
family: Arial; font-size: 15px;">Chinese hair factories purchase Indian was=
te hair, and process it with chemicals, and mix it with animal fibers=
=2E It's packaged, and labeled as 100% virgin hair, and truthfully, it may =
 contain only 20%  human hair=2E=C2=A0</span></div><div style=3D"line-heigh=
t: 150%;"><font face=3D"Arial" style=3D"font-size: 16px;"><span style=
=3D"font-family: Arial; font-size: 15px;"><br></span></font></div><div styl=
e=3D"line-height: 150%;"><font face=3D"Arial"><span style=3D"font-family: A=
rial; font-size: 26px;"><b>Charlye B is fed up with the lies!=C2=A0</b></sp=
an></font></div><div style=3D"line-height: 150%;"><font face=3D"Arial" styl=
e=3D"font-size: 16px;"><span style=3D"font-family: Arial; font-size: 15px;"=
>We give you raw 100% Indian hair, that will  last for 5 years, with proper=
 care! We offer the best hair your money can buy!</span></font></div></div>=
</div></div></td><td style=3D"font-size:1px;" width=3D"10">&nbsp; </td>
</tr></table></div></div></v:textbox></v:rect></td><td width=3D"37" class=
=3D"layout-block-padding-right" bgcolor=3D"#ebebeb">&nbsp; </td>
</tr></table><![endif]--></div>
		=09
			<div style=3D"background-image:url(box-bg=2Ejpg); background-position: l=
eft top; " width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"box-bg=2Ejpg" b=
gcolor=3D"#e6e6e6" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td width=3D"37" class=3D"EQ-09" style=3D"font-size:1px; ">&nbsp;</td=
>
						<td height=3D"41" background=3D"box-bg=2Ejpg" class=3D"EQ-0B" bgcolor=
=3D"#e6e6e6" width=3D"676">

							<div class=3D"spacer">
						</div>

</td>
						<td width=3D"37" class=3D"EQ-0A" style=3D"font-size:1px; ">&nbsp;</td=
>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"37" class=3D"layout-block-padding-left" style=3D"font-size=
:0"><v:rect style=3D"width:37px;height:41px;" stroke=3D"f"><v:fill type=
=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fill>&nbsp; </v:rect><=
/td><td class=3D"layout-block-content-cell" style=3D"font-size:0;" width=
=3D"676" height=3D"41"><v:rect style=3D"width:676px;height:41px;" stroke=
=3D"f"><v:fill type=3D"tile" src=3D"box-bg=2Ejpg" color=3D"#ebebeb"></v:fil=
l><div class=3D"spacer"></div></v:rect></td><td width=3D"37" class=3D"layou=
t-block-padding-right" style=3D"font-size:0"><v:rect style=3D"width:37px;he=
ight:41px;" stroke=3D"f"><v:fill type=3D"tile" src=3D"box-bg=2Ejpg" color=
=3D"#ebebeb"></v:fill>&nbsp; </v:rect></td>
</tr></table><![endif]--></div>
		=09
			<div style=3D"background-image:url(background-3=2Ejpg); background-posit=
ion: left top; " width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"background-3=
=2Ejpg" bgcolor=3D"#131418" style=3D"mso-hide:all; ">
					<tbody><tr>
						<td width=3D"37" class=3D"EQ-0D">&nbsp;</td>
						<td background=3D"box-bg-1=2Ejpg" class=3D"EQ-0F" bgcolor=3D"#131317"=
 width=3D"676">
							<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" style=
=3D"padding-left: 10px; padding-right: 10px; " class=3D"layout-block-padded=
-column" width=3D"676">
								<tbody><tr>
									<td valign=3D"top" class=3D"layout-block-padded-column" align=
=3D"center" width=3D"656">
										<div class=3D"layout-block-image">
											<img width=3D"656" height=3D"300" alt=3D"" src=3D"http://chuckad=
amsphotos=2Ecom/emarketingcb/image-16=2Ejpg" border=3D"0" style=3D"line-hei=
ght: 1px; display: block; width: 656px; height: 300px; " class=3D"EQ-10">
										</div>
									</td>
								</tr>
							</tbody></table>
						</td>
						<td width=3D"37" class=3D"EQ-0E">&nbsp;</td>
					</tr>
				</tbody></table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"37" class=3D"layout-block-padding-left"><v:rect style=
=3D"width:37px;height:300px;" stroke=3D"f"><v:fill type=3D"tile" src=
=3D"background-3=2Ejpg" color=3D"#191a1f"></v:fill>&nbsp; </v:rect></td><td=
 class=3D"layout-block-content-cell" width=3D"676"><v:rect style=3D"width:6=
76px;" stroke=3D"f"><v:fill type=3D"tile" src=3D"box-bg-1=2Ejpg" color=
=3D"#18191e"></v:fill><v:textbox style=3D"mso-fit-shape-to-text:true" inset=
=3D"0,0,0,0"><div><div style=3D"font-size:0"><table cellspacing=3D"0" cellp=
adding=3D"0" align=3D"left" style=3D"padding-left:10px; padding-right:10px;=
" class=3D"layout-block-padded-column">
<tr><td valign=3D"top" class=3D"layout-block-padded-column" align=3D"center=
"><div class=3D"layout-block-image"><img height=3D"300" alt=3D"" src=
=3D"image-16=2Ejpg" border=3D"0" style=3D"line-height: 1px; display: block;=
"  class=3D"img-EQMST-7C296DAB-3787-4BE8-B869-7BFB42B0BE21" width=3D"656"><=
/img><div style=3D"width:0px;height:0px;max-height:0;max-width:0;overflow:h=
idden;display:none;visibility:hidden;mso-hide:all;"></div></div></td>
</tr></table></div></div></v:textbox></v:rect></td><td width=3D"37" class=
=3D"layout-block-padding-right"><v:rect style=3D"width:37px;height:300px;" =
stroke=3D"f"><v:fill type=3D"tile" src=3D"background-3=2Ejpg" color=3D"#191=
a1f"></v:fill>&nbsp; </v:rect></td>
</tr></table><![endif]--></div>
		=09
			<div width=3D"100%" class=3D"desktop-only">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"mso-fixed-width-wrapping-table" style=3D"mso-hide:all; ">
				<tbody>
<tr>
					<td width=3D"750">
					=09
						<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-full-width" width=3D"150">
							<tbody>
<tr>
								<td width=3D"150" valign=3D"top" class=3D"layout-block-column" alig=
n=3D"center">
									<div class=3D"layout-block-image">
										<img width=3D"150" height=3D"88" alt=3D"" src=3D"http://chuckadam=
sphotos=2Ecom/emarketingcb/image-6=2Ejpg" border=3D"0" style=3D"line-height=
: 1px; display: block; width: 150px; height: 88px; ">
									</div>
								</td>
							</tr>
						</tbody>
</table>
						<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-full-width" width=3D"150">
							<tbody>
<tr>
								<td width=3D"150" valign=3D"top" class=3D"layout-block-column" alig=
n=3D"center">
									<div class=3D"layout-block-image">
										<img width=3D"150" height=3D"88" alt=3D"" src=3D"http://chuckadam=
sphotos=2Ecom/emarketingcb/image-9=2Ejpg" border=3D"0" style=3D"line-height=
: 1px; display: block; width: 150px; height: 88px; ">
									</div>
								</td>
							</tr>
						</tbody>
</table>
						<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-full-width" width=3D"150">
							<tbody>
<tr>
								<td width=3D"150" valign=3D"top" class=3D"layout-block-column" alig=
n=3D"center">
									<div class=3D"layout-block-image">
										<a href=3D"https://www=2Einstagram=2Ecom/charlyebhair/"><img widt=
h=3D"150" height=3D"88" alt=3D"" src=3D"http://chuckadamsphotos=2Ecom/emark=
etingcb/image-8=2Ejpg" border=3D"0" style=3D"display: block; width: 150px; =
height: 88px; "></a>
									</div>
								</td>
							</tr>
						</tbody>
</table>
						<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-full-width" width=3D"150">
							<tbody>
<tr>
								<td width=3D"150" valign=3D"top" class=3D"layout-block-column" alig=
n=3D"center">
									<div class=3D"layout-block-image">
										<img width=3D"150" height=3D"88" alt=3D"" src=3D"http://chuckadam=
sphotos=2Ecom/emarketingcb/image-9=2Ejpg" border=3D"0" style=3D"line-height=
: 1px; display: block; width: 150px; height: 88px; ">
									</div>
								</td>
							</tr>
						</tbody>
</table>
						<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-full-width" width=3D"150">
							<tbody>
<tr>
								<td width=3D"150" valign=3D"top" class=3D"layout-block-column" alig=
n=3D"center">
									<div class=3D"layout-block-image">
										<img width=3D"150" height=3D"88" alt=3D"" src=3D"http://chuckadam=
sphotos=2Ecom/emarketingcb/image-9=2Ejpg" border=3D"0" style=3D"line-height=
: 1px; display: block; width: 150px; height: 88px; ">
									</div>
								</td>
							</tr>
						</tbody>
</table>
					=09
					=09
					</td>
				</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"mso-fixed-width-wrapping-table" width=3D"750">
<tr><td width=3D"750"><table width=3D"750" cellspacing=3D"0" cellpadding=
=3D"0">
<tr><td valign=3D"top" class=3D"layout-block-column" align=3D"center" width=
=3D"150"><div class=3D"layout-block-image"><img height=3D"88" alt=3D"" src=
=3D"image-6=2Ejpg" border=3D"0" style=3D"line-height: 1px; display: block;"=
 class=3D"img-EQMST-D436532B-BC1E-4501-9BD5-957604BD7054" width=3D"150"></i=
mg><div style=3D"width:0px;height:0px;max-height:0;max-width:0;overflow:hid=
den;display:none;visibility:hidden;mso-hide:all;"></div></div></td><td widt=
h=3D"150" valign=3D"top" class=3D"layout-block-column" align=3D"center"><di=
v class=3D"layout-block-image"><img height=3D"88" alt=3D"" src=3D"image-9=
=2Ejpg" border=3D"0" style=3D"line-height: 1px; display: block;" class=
=3D"img-EQMST-B6AD91A7-3796-411D-988F-B44E8539CE85" width=3D"150"></img><di=
v style=3D"width:0px;height:0px;max-height:0;max-width:0;overflow:hidden;di=
splay:none;visibility:hidden;mso-hide:all;"></div></div></td><td width=
=3D"150" valign=3D"top" class=3D"layout-block-column" align=3D"center"><div=
 class=3D"layout-block-image"><a href=3D"https://www=2Einstagram=2Ecom/char=
lyebhair/"><img height=3D"88" alt=3D"" src=3D"image-8=2Ejpg" border=3D"0" s=
tyle=3D"display: block;" class=3D"img-EQMST-49F9DA01-27E0-470C-95DF-DB1C268=
8D13B" width=3D"150"></img><div style=3D"width:0px;height:0px;max-height:0;=
max-width:0;overflow:hidden;display:none;visibility:hidden;mso-hide:all;"><=
/div></a></div></td><td width=3D"150" valign=3D"top" class=3D"layout-block-=
column" align=3D"center"><div class=3D"layout-block-image"><img height=
=3D"88" alt=3D"" src=3D"image-9=2Ejpg" border=3D"0" style=3D"line-height: 1=
px; display: block;" class=3D"img-EQMST-4080B7ED-D4B5-49CF-9670-197A936092A=
4" width=3D"150"></img><div style=3D"width:0px;height:0px;max-height:0;max-=
width:0;overflow:hidden;display:none;visibility:hidden;mso-hide:all;"></div=
></div></td><td width=3D"150" valign=3D"top" class=3D"layout-block-column" =
align=3D"center"><div class=3D"layout-block-image"><img height=3D"88" alt=
=3D"" src=3D"image-9=2Ejpg" border=3D"0" style=3D"line-height: 1px; display=
: block;" class=3D"img-EQMST-9B6F3518-06AA-422B-8F85-52CD959F49B1" width=
=3D"150"></img><div style=3D"width:0px;height:0px;max-height:0;max-width:0;=
overflow:hidden;display:none;visibility:hidden;mso-hide:all;"></div></div><=
/td>
</tr></table></td>
</tr></table><![endif]--></div>
		=09
			<div width=3D"100%" class=3D"desktop-only">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td valign=3D"top" class=3D"layout-block-full-width" width=3D"750">
							<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-ful=
l-width" width=3D"750">
								<tbody>
<tr>
									<td width=3D"750">
										<div class=3D"layout-block-image">
											<img width=3D"750" height=3D"29" alt=3D"" src=3D"http://chuckada=
msphotos=2Ecom/emarketingcb/image-2=2Epng" border=3D"0" style=3D"line-heigh=
t: 1px; display: block; width: 750px; height: 29px; ">
									=09
</div>
									</td>
								</tr>
							</tbody>
</table>
						</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table width=3D"750" cellspacing=
=3D"0" cellpadding=3D"0" class=3D"mso-fixed-width-wrapping-table">
<tr><td valign=3D"top" class=3D"layout-block-full-width"><div class=3D"layo=
ut-block-image"><img height=3D"29" alt=3D"" src=3D"image-2=2Epng" border=
=3D"0" style=3D"line-height: 1px; display: block;" class=3D"img-EQMST-A077F=
7DE-E9E9-48DF-AF38-BE47AF9E1960" width=3D"750"></img><div style=3D"width:0p=
x;height:0px;max-height:0;max-width:0;overflow:hidden;display:none;visibili=
ty:hidden;mso-hide:all;"></div></div></td>
</tr></table><![endif]--></div>
		=09
			<div style=3D"background-image:url(page-bg=2Ejpg); background-position: =
0% 0%; " width=3D"100%">
				<!--[if !mso 15]><!--><table width=3D"750" cellspacing=3D"0" cellpaddin=
g=3D"0" class=3D"layout-block-wrapping-table" background=3D"page-bg=2Ejpg" =
bgcolor=3D"#ffffff" style=3D"mso-hide:all; ">
					<tbody>
<tr>
						<td width=3D"121" class=3D"EQ-11">&nbsp;</td>
						<td class=3D"EQ-13" width=3D"518">
							<table cellspacing=3D"0" cellpadding=3D"0" align=3D"left" class=
=3D"layout-block-column">
								<tbody>
<tr>
									<td width=3D"498" valign=3D"top" align=3D"left" background=3D"box-=
bg-3=2Ejpg" style=3D"padding-left: 10px; padding-right: 10px; " bgcolor=
=3D"#ffffff">
										<table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-=
box-padding">
											<tbody>
<tr>
												<td align=3D"left" class=3D"layout-block-column" width=3D"498">=

													<div class=3D"text" style=3D"font-size: 16px; font-family: 'Lu=
cida Grande'; ">
<div style=3D"color: rgb(169, 169, 169); font-family: Arial; font-size: 13p=
x; font-style: normal; font-weight: normal; line-height: 1=2E5; text-align:=
 center; text-decoration: none; ">Nish C=2E Johnson | Vendor Relations | O:=
 646=2E844=2E2953&nbsp;</div><div style=3D"color: rgb(169, 169, 169); font-=
family: Arial; font-size: 13px; font-style: normal; font-weight: normal; li=
ne-height: 1=2E5; text-align: center; text-decoration: none; ">One World Tr=
ade Center: 285 Fulton St, Suite 8500 Manhattan, NY 10007</div><div style=
=3D"color: rgb(169, 169, 169); font-family: Arial; font-size: 13px; font-st=
yle: normal; font-weight: normal; line-height: 1=2E5; text-align: center; t=
ext-decoration: none; "><br></div><div style=3D"color: rgb(169, 169, 169); =
font-family: Arial; font-size: 13px; font-style: normal; font-weight: norma=
l; line-height: 1=2E5; text-align: center; text-decoration: none; "><a href=
=3D"https://www=2Echarlyeb=2Ecom">website</a>  - <a href=3D"https://www=
=2Einstagram=2Ecom/charlyebhair/">Instagram</a>&nbsp;</div>
														</div>
												</td>
											</tr>
										</tbody>
</table>
									</td>
								</tr>
							</tbody>
</table>
						</td>
						<td width=3D"111" class=3D"EQ-12">&nbsp;</td>
					</tr>
				</tbody>
</table>
			<!--<![endif]--><!--[if gte mso 9]><table cellspacing=3D"0" cellpadding=
=3D"0" class=3D"layout-block-wrapping-table" width=3D"750">
<tr><td width=3D"121" class=3D"layout-block-padding-left">&nbsp; </td><td w=
idth=3D"518" class=3D"layout-block-content-cell" valign=3D"top" align=
=3D"left"><v:rect style=3D"width:518px;" stroke=3D"f"><v:fill type=3D"tile"=
 src=3D"box-bg-3=2Ejpg" color=3D"#ffffff"></v:fill><v:textbox style=3D"mso-=
fit-shape-to-text:true" inset=3D"0,0,0,0"><div><div style=3D"font-size:0"><=
table cellspacing=3D"0" cellpadding=3D"0" class=3D"layout-block-box-padding=
">
<tr><td style=3D"font-size:1px;" width=3D"10">&nbsp; </td><td align=3D"left=
" class=3D"layout-block-column" width=3D"498"><div class=3D"text" style=
=3D"font-size: 16px; font-family: sans-serif;">
<div style=3D"color: rgb(169, 169, 169); font-family: Arial; font-size: 13p=
x; font-style: normal; font-weight: normal; line-height: 150%; text-align: =
center; text-decoration: none;">Nish C=2E Johnson | Vendor Relations | O: 6=
46=2E844=2E2953=C2=A0</div><div style=3D"color: rgb(169, 169, 169); font-fa=
mily: Arial; font-size: 13px; font-style: normal; font-weight: normal; line=
-height: 150%; text-align: center; text-decoration: none;">One World Trade =
Center: 285 Fulton St, Suite 8500 Manhattan, NY 10007</div><div style=
=3D"color: rgb(169, 169, 169); font-family: Arial; font-size: 13px; font-st=
yle: normal; font-weight: normal; line-height: 150%; text-align: center; te=
xt-decoration: none;"><br></div><div style=3D"color: rgb(169, 169, 169); fo=
nt-family: Arial; font-size: 13px; font-style: normal; font-weight: normal;=
 line-height: 150%; text-align: center; text-decoration: none;"><a href=
=3D"https://www=2Echarlyeb=2Ecom">website</a> - <a href=3D"https://www=
=2Einstagram=2Ecom/charlyebhair/">Instagram</a>=C2=A0</div>
														</div></td><td style=3D"font-size:1px;" width=3D"10">&nbsp; <=
/td>
</tr></table></div></div></v:textbox></v:rect></td><td width=3D"111" class=
=3D"layout-block-padding-right">&nbsp; </td>
</tr></table><![endif]--></div>
		=09
		</div>
		<!--End of layout container -->
	=09
	</td>
	<td width=3D"30" class=3D"page-bg-show-thru">&nbsp;<!--Right page bg show-=
thru -->
</td>
</tr>
</tbody>
</table>
<!--email-body -->

	</td>
</tr>
</tbody>
</table>
<!--page-wrap -->



</body></html>

----=BOUNDARY_1125744_SAXS_BCAE_HPYG_ICDO--

