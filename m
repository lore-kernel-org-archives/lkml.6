Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xzrpFpmfGVtLVwAAmS7hNA
	; Thu, 07 Jun 2018 22:07:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53539606DD; Thu,  7 Jun 2018 22:07:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=BAYES_20,
	FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 29D38605A2;
	Thu,  7 Jun 2018 22:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29D38605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=rohagroup.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeFGWHn convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 18:07:43 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.14]:36895 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751739AbeFGWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:07:41 -0400
Received: from [216.82.251.38] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-14.bemta-12.messagelabs.com id 04/FB-07800-9ACA91B5; Thu, 07 Jun 2018 22:07:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRjed87Z2TE8ddwmfg7qx4oy05VG9UU
  /iujyUQT9CSqzOtbRrXaxnWmLoMRUao20TMGVl1VKpmaJiJfI1BIspVLB0kidmmaUXchSytrZ
  qOzPy8P3XN4HvpchldNyDSPYbYLVzBu19BzK7jAPRZaWh8asyCsIQTn1HhpdLakh0MXOswB1p
  jTRqO/KVwLlT1WRqKv+Ko2uFbcS6MyNLAKllMSirJ5pEv2sfEWj4dS1yDPjIdGjAg9A1y4MAF
  R9vUCO3CMjCnT5wzr0ozATbFDj4pfPKFz1cYjAE2VdAPc3lCpwcX6ZAg8522nc66mm8UBbJsC
  lP3PluKugToG7xqYUOK1sK36Yex/gL1ULsMvVQuDn+U/pnUF75QZznMV+UK6fSM+gEt8T9rbR
  VkUKqCQcIIBRcqMATvbvkDDJ6eCLnMu0hFkuCLblDVP+92WwxP2OdADGixfDrw6bBFWcCg7+i
  pcUai4C1vVU+tQ0twK25BfJJQnFLYIN7mD/Ii1srPhO+sO3w8r0J7T/PQx2T9X4rJBbCB1Nfa
  Qfx8Mr2RlEFpjrmtXNNauba1Y3179uRYC6BcJEwZosWCNXrtLFWQ0JepuJNxgjo6KidSZBFPk
  EwcjHibpDFlMV8P7xaZkM1II3jTHNIJQhtMEsGxsao5wbZzl8Qs+L+gPWJKMgNgMdw3DPOgY/
  A6774+dUQkOZLWZBC9njZV51kFVIEOzxBqP3dP4YIBOoVbMbJZoVE3mTaEjwU4/Besb51OEkm
  fYMp3e+9s3u3hwnqfSlakLYesnGSTZ9kvlv6J+T7ATzNSoWyGQyZWCiYDUZbP/z4yCEAVoVe1
  NKCTSYbX93j3trEd5amPTVsvH/KE0KSLszNpE9Lze8PVB1cdzV6W5fM5NEDrqPx4SEmiqWbJr
  ZWD5e+GByS+3g0V/nNlOTRdO7wuUjprc8bezdbczJ/l53N4BLVh7rzzvZc35Pk7ot/ba6GC/f
  Fj11L9my351+o3l1akAEXLpgw6Vv++6DzL0Zhy8d+ZR2ovxUx+nnZwvHdmspUc9HhZNWkf8NC
  x3vVY0DAAA=
X-Env-Sender: Roha.Thailand@rohagroup.com
X-Msg-Ref: server-9.tower-163.messagelabs.com!1528409245!160940780!11
X-Originating-IP: [120.138.110.227]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 47271 invoked from network); 7 Jun 2018 22:07:37 -0000
Received: from 227-110-138-120.mysipl.com (HELO mail.rohagroup.com) (120.138.110.227)
  by server-9.tower-163.messagelabs.com with AES256-SHA256 encrypted SMTP; 7 Jun 2018 22:07:37 -0000
Received: from [100.90.137.67] (106.223.108.196) by exchange16.rohagroup.com
 (192.168.1.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.669.32; Fri, 8 Jun 2018
 03:37:15 +0530
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Hello Dear
To: Recipients <roha.thailand@rohagroup.com>
From: Charles Koch <roha.thailand@rohagroup.com>
Date: Thu, 7 Jun 2018 15:07:15 -0700
Reply-To: <chkoch2329@dbzmail.com>
Message-ID: <793b5d85-6808-4019-87b5-02fc895e0a43@exchange16.rohagroup.com>
X-Originating-IP: [106.223.108.196]
X-ClientProxiedBy: exchange16.rohagroup.com (192.168.1.34) To
 exchange16.rohagroup.com (192.168.1.34)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fellow

Charles Koch here, ceo charles koch foundation worldwide (the largest charity foundation in the world).
This year under our motto of "Give while living", i and the foundation have decided to award $500,000.00
to a few selected lucky individuals and on receipt of this email kindly get back to me.


Regards,
Charles Koch.
chkoch2329@dbzmail.com
