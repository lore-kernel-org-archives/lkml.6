Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XNF2Ov6KGFu9eAAAmS7hNA
	; Thu, 07 Jun 2018 01:31:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4160608B8; Thu,  7 Jun 2018 01:31:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=tzuchi.us header.i=@tzuchi.us header.b="gna8DM9B"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,LOTS_OF_MONEY,MAILING_LIST_MULTI,US_DOLLARS_3
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68EA2607E4;
	Thu,  7 Jun 2018 01:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68EA2607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=tzuchi.us
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFGBbk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:31:40 -0400
Received: from antispam.tzuchi.us ([108.59.225.74]:52564 "HELO
        antispam.us.tzuchi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752189AbeFGBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:31:38 -0400
X-Greylist: delayed 1159 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 21:31:28 EDT
X-ASG-Debug-ID: 1528276275-0a19b13d7d57050001-xx1T2L
Received: from zmail.us.tzuchi.org ([10.4.4.122]) by antispam.us.tzuchi.org with ESMTP id JcDl7RtUkSt6yynY (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 06 Jun 2018 02:11:15 -0700 (PDT)
X-Barracuda-Envelope-From: debbie_lin@tzuchi.us
X-Barracuda-RBL-Trusted-Forwarder: 10.4.4.122
X-ASG-Whitelist: Client
Received: from localhost (localhost [127.0.0.1])
        by zmail.us.tzuchi.org (Postfix) with ESMTP id 7948081DD7763E;
        Wed,  6 Jun 2018 02:11:14 -0700 (PDT)
Received: from zmail.us.tzuchi.org ([127.0.0.1])
        by localhost (zmail.us.tzuchi.org [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aBL5wgLRel3j; Wed,  6 Jun 2018 02:11:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zmail.us.tzuchi.org (Postfix) with ESMTP id 214368013052CF;
        Wed,  6 Jun 2018 02:11:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmail.us.tzuchi.org 214368013052CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tzuchi.us;
        s=191B4558-3A08-11E5-9BA7-350D9DCB4428; t=1528276272;
        bh=L5mx/54g6Ab2aM2GTGSxaaXRdjiKkVw+HEpRfGBk2vo=;
        h=Date:From:Message-ID:MIME-Version;
        b=gna8DM9BvD9iA8Dj3IaS2JWS6scXTXv9hJ8iX+3U6BpfG3XQOyUGgF9I0g9rlXlDr
         qiiZLInxpMxYKhFu2FzDUKFktFnEG/lWIb3HujURmUe9BY945SJrYvkTDUEl76gwiF
         9TXNdIv9IPYaeQgozg/3YFNurx22SwlDDxENFToo=
X-Virus-Scanned: amavisd-new at zmail.us.tzuchi.org
Received: from zmail.us.tzuchi.org ([127.0.0.1])
        by localhost (zmail.us.tzuchi.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-a4H5aPLtAf; Wed,  6 Jun 2018 02:11:12 -0700 (PDT)
Received: from zmail.us.tzuchi.org (zmail.us.tzuchi.org [10.4.4.122])
        by zmail.us.tzuchi.org (Postfix) with ESMTP id 56AC281DAE97BD;
        Wed,  6 Jun 2018 02:11:10 -0700 (PDT)
Date: Wed, 6 Jun 2018 02:11:10 -0700 (PDT)
X-Barracuda-RBL-Trusted-Forwarder: 10.4.4.122
From: Robert Lee <debbie_lin@tzuchi.us>
Reply-To: Robert Lee <rob322lee@gmail.com>
Message-ID: <407863039.1962389.1528276270263.JavaMail.zimbra@tzuchi.us>
Subject: Hi
MIME-Version: 1.0
X-ASG-Orig-Subj: Hi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [72.13.91.228]
X-Mailer: Zimbra 8.7.1_GA_1670 (zclient/8.7.1_GA_1670)
Thread-Index: AIVVtOBIjAC0ojaeOQw7//I7CQy9DA==
Thread-Topic: Hi
X-Barracuda-Connect: UNKNOWN[10.4.4.122]
X-Barracuda-Start-Time: 1528276275
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://10.4.4.74:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 370
X-Barracuda-BRTS-Status: 1
X-Barracuda-Fingerprint-Found: *Spam.Unknown (d2d3e5053cf684bc9aa7425d6e95d4a4-367-txt)
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am a United State Army here in Afghanistan, am seeking your help to evacuate the sum of $ 7,000,000 to you as long as I am assured it will be safe That in your care Until I complete my service here in Afghanistan. This is not stolen money and there are no dangers involved. I count on your understanding. Please get back for more information :. rob322lee@gmail.com
