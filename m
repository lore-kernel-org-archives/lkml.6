Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeDPLKr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:10:47 -0400
Received: from smtprelay0240.b.hostedemail.com ([64.98.42.240]:46002 "EHLO
        smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751124AbeDPLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:10:46 -0400
X-Session-Marker: 742E617274656D406C79636F732E636F6D
X-Spam-Summary: 13,1.2,0,,d41d8cd98f00b204,t.artem@lycos.com,:,RULES_HIT:41:355:379:560:582:988:989:1152:1260:1277:1311:1313:1314:1345:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2693:3138:3139:3140:3141:3142:3353:3421:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4361:5007:6261:8784:8828:9108:10008:10400:10848:11473:11658:11914:12050:12485:12760:12895:13069:13071:13075:13161:13211:13229:13311:13357:13439:14096:14097:14180:14659:14685:14721:14879:21080:21627:30034:30054:30070,0,RBL:64.98.36.5:@lycos.com:.lbl8.mailshell.net-62.22.55.100 66.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fs,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:9,LUA_SUMMARY:none
X-HE-Tag: place01_6269a79d58035
X-Filterd-Recvd-Size: 1934
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 16:04:35 +0500
From: "Artem S. Tashkinov" <t.artem@lycos.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: On the kernel numbering scheme
Message-ID: <e7b554d738de83268f4fc06dd6f12ada@lycos.com>
User-Agent: Roundcube Webmail/1.2.7
X-Originating-IP: [196.52.84.52]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I know this proposal has already been made great many times but I'd like 
to repeat it and have a healthy discussion about it.

The current kernel numbering scheme makes no sense at all because the 
first two numbers don't represent anything at all. They had some meaning 
back in the 1.x 2.x 3.x days but then with the introduction of the new 
rolling development model, they became worthless.

I'd love to change the kernel numbering scheme to this:

YYYY.RELEASE.PATCH_LEVEL

So that the first kernel to be released in 2019 will be numbered 
2019.0(.0), and its consequent releases will be 2019.1, 2019.2, 2019.3, 
etc. and its stable patches will be 2019.0.1, 2019.0.2, 2019.0.3, 
2019.0.4, etc.

With this scheme you can easily see how fresh your kernel is and there's 
no need arbitrary raise the first number because it always matches the 
current year.

There's one minor detail which might raise some questions: there are 
release candidates and then there's a release, so for the development 
which starts before the year end we might start with e.g. 2018.5-rc1 and 
then if the actual release crosses a new year mark we simply turn 
2018.5-rc7 into 2019.0.0.

Best regards,
Artem S. Tashkinov
