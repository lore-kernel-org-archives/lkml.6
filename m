Return-Path: <SRS0=Jrdg=NJ=techyexperts.com=info@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MIME_HTML_ONLY,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:37:58 +0000 (UTC)
X-Greylist: delayed 3219 seconds by postgrey-1.34 at mail.kernel.org; Mon, 29 Oct 2018 19:37:57 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=techyexperts.com header.i=@techyexperts.com header.b="Kj5lQEt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5062082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techyexperts.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=info@techyexperts.com
Received: from web1.evovps.com (web1.evovps.com [46.105.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5062082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=techyexperts.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:List-Unsubscribe:Message-ID:Reply-To:From:Date:Subject:To:Sender
	:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eh6tSvOt5oLcJbmokr44POepksUQcqppIruLZyR/72w=; b=Kj5lQEt2RKda6E9+tuDT23x9Wx
	7zJLJ+Z2MFN84ekHeSk1fKBR5hkBeNlroAkDyUzWNccsjSR7Sk+iLDsWFJOwiD2VtpXOa2DhYeGxe
	vcI7q9DY0S5iY5MKxfCt2KmTOTNAwrhYGg37QbySIwuZSKsEKazBdvj223Di4Jt90Ba6q1rnljxf6
	zpniyGwRCpZwQgbXQjooAE68cQyBIh6jZZdlljkyc98ayv2iGejy6YiyS783S0EN2TDMFJGu1ChvF
	LKgIe9J0BNGVjERjKB2z4NK26zCDq8E7rzeZHs+9jKlLLHKaDQNbw7aMBQ+qfOiSbUnVzIu+BdhFq
	peOrdx6w==;
Received: from techyexp by web1.evovps.com with local (Exim 4.91)
	(envelope-from <info@techyexperts.com>)
	id 1gHCWR-006aoR-T6
	for linux-kernel@archiver.kernel.org; Mon, 29 Oct 2018 19:44:19 +0100
To: linux-kernel@archiver.kernel.org
Subject: Audio Transcription Service Provider
X-PHP-Script: techyexperts.com/wp-cron.php for 46.105.105.77, 46.105.105.77
X-PHP-Filename: /home/techyexp/public_html/wp-cron.php REMOTE_ADDR: 46.105.105.77
Date: Mon, 29 Oct 2018 18:44:16 +0000
From: Meryl Cook <info@techyexperts.com>
Reply-To: Meryl Cook <info@tecksmew.com>
Message-ID: <6d917f96c98360fe844a0a1d82a84c90@techyexperts.com>
X-Priority: 3
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
Precedence: bulk
List-Unsubscribe: https://techyexperts.com/manage-subscriptions/
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - web1.evovps.com
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [761 768] / [47 12]
X-AntiAbuse: Sender Address Domain - techyexperts.com
X-Get-Message-Sender-Via: web1.evovps.com: authenticated_id: techyexp/from_h
X-Authenticated-Sender: web1.evovps.com: info@techyexperts.com
List-Id: <linux-kernel.vger.kernel.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
	<head>
		<meta name="viewport" content="width=device-width" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>My Blog</title>
		
		<style type="text/css">
		/* -------------------------------------
		    GLOBAL
		    A very basic CSS reset
		------------------------------------- */
		* {
		  margin: 0;
		  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		  box-sizing: border-box;
		  /*font-size: 14px;*/
		}
		
		img {
		  max-width: 100%;
		  height: auto;
		}
		
		body {
		  -webkit-font-smoothing: antialiased;
		  -webkit-text-size-adjust: none;
		  width: 100% !important;
		  height: 100%;
		  line-height: 1.6;
		  font-size: 14px;
		}
		
		/* Let's make sure all tables have defaults */
		table td {
		  vertical-align: top;
		}
		
		/* -------------------------------------
		    BODY & CONTAINER
		------------------------------------- */
		body {
		  background-color: #f6f6f6;
		  font-size: 14px;
		  line-height: auto;
		}
		
		.body-wrap {
		  background-color: #f6f6f6;
		  width: 100%;
		}
		
		.container {
		  display: block !important;
		  max-width: 600px !important;
		  margin: 0 auto !important;
		  /* makes it centered */
		  clear: both !important;
		}
		
		.content {
		  max-width: 600px;
		  margin: 0 auto;
		  display: block;
		  padding: 20px;
		}
		
		/* -------------------------------------
		    HEADER, FOOTER, MAIN
		------------------------------------- */
		.main {
		  background-color: #fff;
		  border: 1px solid #e9e9e9;
		  border-radius: 3px;
		}
		
		.content-wrap {
		  padding: 20px;
		}
		
		.content-block {
		  padding: 0 0 20px;
		}
		
		.header {
		  width: 100%;
		  margin-bottom: 20px;
		}
		
		.footer {
		  width: 100%;
		  clear: both;
		  color: #999;
		  padding: 20px;
		}
		.footer a {
		  color: #999;
		}
		.footer p, .footer a, .footer unsubscribe, .footer td {
		  font-size: 12px;
		}
		
		/* -------------------------------------
		    TYPOGRAPHY
		------------------------------------- */
		h1, h2, h3 {
		  font-family: "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
		  color: #000;
		  margin: 40px 0 20px 0;
		  line-height: 1.2;
		  font-weight: bold;
		}
		
		h1 {
		  font-size: 32px;
		  font-weight: 500;
		}
		
		h2 {
		  font-size: 24px;
		}
		
		h3 {
		  font-size: 18px;
		}
		
		h4 {
		  font-size: 14px;
		  font-weight: 600;
		}
		
		p, ul, ol {
			margin-top: 10px;
		  margin-bottom: 15px;
		  font-weight: normal;
		}
		p li, ul li, ol li {
		  margin-left: 5px;
		  list-style-position: inside;
		}
		
		/* -------------------------------------
		    LINKS & BUTTONS
		------------------------------------- */
		a {
		  color: #348eda;
		  text-decoration: underline;
		}
		
		.btn-primary, .newsletters_button {
		  text-decoration: none;
		  color: #FFF;
		  background-color: #348eda;
		  border: solid #348eda;
		  border-width: 10px 20px;
		  line-height: 2;
		  font-weight: bold;
		  text-align: center;
		  cursor: pointer;
		  display: inline-block;
		  border-radius: 5px;
		  text-transform: capitalize;
		}
		
		/* -------------------------------------
		    OTHER STYLES THAT MIGHT BE USEFUL
		------------------------------------- */
		.last {
		  margin-bottom: 0;
		}
		
		.first {
		  margin-top: 0;
		}
		
		.aligncenter {
		  text-align: center;
		}
		
		.alignright {
		  text-align: right;
		}
		
		.alignleft {
		  text-align: left;
		}
		
		.clear {
		  clear: both;
		}
		
		hr {
		    border: 0;
		    height: 0;
		    border-top: 1px solid rgba(0, 0, 0, 0.1);
		    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
		}
		
		/* -------------------------------------
		    ALERTS
		    Change the class depending on warning email, good email or bad email
		------------------------------------- */
		.alert {
		  font-size: 16px;
		  color: #fff;
		  font-weight: 500;
		  padding: 20px;
		  text-align: center;
		  border-radius: 3px 3px 0 0;
		}
		.alert a {
		  color: #fff;
		  text-decoration: none;
		  font-weight: 500;
		  font-size: 16px;
		}
		.alert.alert-warning {
		  background-color: #FF9F00;
		}
		.alert.alert-bad {
		  background-color: #D0021B;
		}
		.alert.alert-good {
		  background-color: #68B90F;
		}
		
		/* -------------------------------------
		    INVOICE
		    Styles for the billing table
		------------------------------------- */
		.invoice {
		  margin: 40px auto;
		  text-align: left;
		  width: 80%;
		}
		.invoice td {
		  padding: 5px 0;
		}
		.invoice .invoice-items {
		  width: 100%;
		}
		.invoice .invoice-items td {
		  border-top: #eee 1px solid;
		}
		.invoice .invoice-items .total td {
		  border-top: 2px solid #333;
		  border-bottom: 2px solid #333;
		  font-weight: 700;
		}
		
		/* -------------------------------------
		    RESPONSIVE AND MOBILE FRIENDLY STYLES
		------------------------------------- */
		@media only screen and (max-width: 640px) {
		  h1, h2, h3, h4 {
		    font-weight: 600 !important;
		    margin: 20px 0 5px !important;
		  }
		
		  h1 {
		    font-size: 22px !important;
		  }
		
		  h2 {
		    font-size: 18px !important;
		  }
		
		  h3 {
		    font-size: 16px !important;
		  }
		
		  .container {
		    width: 100% !important;
		  }
		
		  .content, .content-wrap {
		    padding: 10px !important;
		  }
		
		  .invoice {
		    width: 100% !important;
		  }
		}
		</style>
	</head>
	
	<body itemscope itemtype="https://schema.org/EmailMessage">
		<table class="body-wrap">
			<tr>
				<td></td>
				<td class="container" width="600">
					<div class="content">
						<table class="main" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td class="alert alert-good">
									Audio Transcription Service Provider
								</td>
							</tr>
							<tr>
								<td class="content-wrap">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td class="content-block">
												<!-- Content Goes Here --><p>Hello,</p>
<p>Do you need someone reliable to transcribe both your short term and long term projects?  Or do you need an accurate transcript for your audio or video?  </p>
<p>Allow us to transcribe your audio and provide you accurate transcripts and let us help you reach your business/project goals through the help of our transcription services.</p>
<p>What are our goals with each transcript?</p>
<p>•	Speed<br />
•	Accuracy<br />
•	Confidentiality</p>
<p>Each transcript is properly formatted. Strict grammar and punctuation rules are adhered to and of course, file security is something we take very seriously. </p>
<p>Have any transcription queries? Send me a message. Let's discuss what you need to get done.  We will address any concerns you have. </p>
<p>- Professional transcription<br />
- Accurate and thorough<br />
- Beautifully transcribed documents.<br />
- Grammar, spelling and jargon thoroughly checked</p>
<p>We have transcribed within most industries:</p>
<p>•	Medical transcription<br />
•	Technological<br />
•	Academic<br />
•	Lectures<br />
•	Business<br />
•	Groups<br />
•	Legal<br />
•	Research interviews<br />
more...</p>
<p>Skilled with international accents and prompt response.  Our pricing is better or comparable to individual service provider.  In addition we also assist in APA Style formatting for research papers.  Please note we don’t conduct research but assist only in formatting of the papers.</p>
<p>Regards,<br />
Meryl Cook</p>
																									<img alt="track" class="newsletters-tracking" src="https://techyexperts.com?wpmlmethod=track&id=945b0a14c0b8773e6f6bdbf36cf332dd" />																							</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<div class="footer">
							<table width="100%">
								<tr>
									
								</tr>
							</table>
						</div>
					</div>
				</td>
				<td></td>
			</tr>
		</table>
	</body>
</html>

