Return-Path: <SRS0=W3P5=P6=transcriptsstars.info=info@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MIME_HTML_ONLY,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99560C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:57:03 +0000 (UTC)
X-Greylist: delayed 1917 seconds by postgrey-1.34 at mail.kernel.org; Tue, 22 Jan 2019 02:57:02 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=transcriptsstars.info header.i=@transcriptsstars.info header.b="HfJGhSza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A088E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=transcriptsstars.info
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=info@transcriptsstars.info
Received: from server3.clever-host.ro (unknown [164.132.19.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A088E20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=transcriptsstars.info; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:List-Unsubscribe:Message-ID:Reply-To:From:Date:Subject:To:Sender
	:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XErSBqcEoo+m9H8g8PyR1Bo6UmtrVL8bq8m5SsL1GiM=; b=HfJGhSzaiEEvQS1fTqymyBrxyr
	UaM7wt5PppXuMhFNqkKAtcLS0A1AiEBN3DU5OWWW+V/f/ltMQgIhTFBirBDbdUECKUgJ1wTemt7c3
	bvQJBSYG676BkIRKmhZMCL0ubi2zuH2fqlHUpmlfz82P+koJ4vjFSVqBoRMLxAedP5sQSyRYkX2JL
	9CDMEjw/YUIbsuOz2EuJmi/r6WFAeyO0+zvdQSHzuR0Edn2VI3QNK0ikoRr3Ioxj68ua6kX/kXCK2
	lLhQW0E/WcYL/KMUB90CdA5d5mDbxR3nihe850yePFF06YswxnJK7TgjtVqo/jmMX0aRIT+cy6cLc
	2+VgR29w==;
Received: from transcri by server3.clever-host.ro with local (Exim 4.91)
	(envelope-from <info@transcriptsstars.info>)
	id 1gllkM-0076KB-O7
	for linux-kernel@archiver.kernel.org; Tue, 22 Jan 2019 04:25:02 +0200
To: linux-kernel@archiver.kernel.org
Subject: Audio Transcription Service Provider
X-PHP-Script: transcriptsstars.info/wp-cron.php for 164.132.19.64
X-PHP-Originating-Script: 644:class-phpmailer.php
Date: Tue, 22 Jan 2019 02:25:02 +0000
From: Clara Hill <info@transcriptsstars.info>
Reply-To: Clara Hill <info@tecksmew.com>
Message-ID: <15246245f604ce481c7d2fc9da35e2c2@transcriptsstars.info>
X-Priority: 3
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
Precedence: bulk
List-Unsubscribe: http://transcriptsstars.info/manage-subscriptions/
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server3.clever-host.ro
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [644 497] / [47 12]
X-AntiAbuse: Sender Address Domain - transcriptsstars.info
X-Get-Message-Sender-Via: server3.clever-host.ro: authenticated_id: transcri/from_h
X-Authenticated-Sender: server3.clever-host.ro: info@transcriptsstars.info
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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
Clara Hill</p>
																									<img alt="track" class="newsletters-tracking" src="http://transcriptsstars.info?wpmlmethod=track&id=399e26ca531287f1ced342e184eea1d7" />																							</td>
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

