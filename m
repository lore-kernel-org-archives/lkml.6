Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DC620864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DC620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbeGKLCu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:02:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:50485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbeGKLCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:02:50 -0400
Received: from [10.50.144.206] ([80.187.115.161]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbVT-1gCXVy3LLn-00aAIy; Wed, 11
 Jul 2018 12:58:42 +0200
Date:   Wed, 11 Jul 2018 12:58:35 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180711102655.GA6864@amd>
References: <20180630131812.GA549@amd> <20180711102655.GA6864@amd>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: v4.18-rc2 on droid4: screen turns red
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, merlijn@wizzup.org
From:   "Marcel Partap (unterwegs)" <mpartap@gmx.net>
Message-ID: <8EB5195E-E329-4001-8C1C-185D25FE6AD3@gmx.net>
X-Provags-ID: V03:K1:iwN2xzPibfUnUtWe6YoS0Z+AwcwHyxMRjzmgIVIKZazFmEY/ZQL
 Ca2aFiHk+e0RRdlwqDUapqwKNXvhl4Z2bqVYFBRNrR831bMxE2DlDwpD+oRy83W+F03Rdx7
 SazznIyKzV/h3CNgTL/KNj1l9/vfpRq0PEL1iRPuf21Zkuxav4EGG/DWpgsXkdQGrs++MLN
 wSKLaA9Gr+6mWkBh2X80A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IgVopr/92es=:kz6WhAYLDlGpTdUwrCizUA
 pvJUbXxsn+G80qguKo6dRDMelQzNfj28D3Vb6SEi+PVMmqIkJzXIJ9Q7EfYTh7vUkeLQBNrZi
 5RfwEyqkd7YLAodXdmQJmdzlmkMUCIDPiGOkA/+C+dDlM1Bo0KtwzmfvEZV0XOHK1g1AT6fZa
 l4k3eDQh+Yce/kTbUE4FRS9I0jt2WhZKSxeVdlBK69COlRxTdABdUYLYPua+ay7VBpRIsLnTu
 NQAvR/6u2UDjGtzffnMxXB6IFBsnRhPJYlCjMJefh/CiwsX14w9xiZbaYx8DbQRVOF75JoRwV
 yfYxKAGrngppJd52G+sK35A8BDYjieTasffx81wiwZtcjO0+aa9y8WT1omRrtBKMezjPfF2gM
 RseZx2xk3muKdYwtwhkR/6vsX35cyp24pBn/acnm55Qztr6jF88Asl1fDkWkO3AEm2GJzf9tI
 D8GgHSwkaPEuScl3Pf1KK2BvIHxTHRCCH6vZatEfatjGjHQEGzVQcAi88ekqO4SLuF3Mb0cb0
 OcGkzyWtkxwEFYwa7VJFLH8CQ+8LtElWPmwqwEvGdvWeG4FxbrVLCUnlSHVxf7Db+jjrUdHFQ
 FaxU3hnqTBb8XRltAjWRedc2szoN7Z9Ju+DBPrp/l2Gzs94N5Ohd1e/5Guy9/LdbDlqrYwJh8
 sHXI2z7zJTlEQYtfRArPkNYaOScZHNEqLFnB9kWePeEYzr8gKXDKwoLoH1MYvhIvzwIPJvVmr
 fiHNtY5uMdczzmX5+XK9hFPjax7S3vCCH50VX4C1dL5oOc3dQ9nrvCDnbVyl/IOhl2YOWxHyP
 y3R0fiY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might this be possible to reproduce with qemu-system-arm, maybe with -icount align=off (?) to speed it up ?
Guess a bisect on the device itself would be kind of a hassle..
If I get my spare droid4 to boot again I'll send it to Prague so you can compare & see if it is somewhat deterministic ; )

Regards!
#marcel


On July 11, 2018 12:26:55 PM CEST, Pavel Machek <pavel@ucw.cz> wrote:
>Hi!
>
>> After longer inactivity, attempt to wake up the screen results in
>> screen being completely red. Not too useful. I can still connect over
>> ssh.
>
>Still there in -rc4 :-(. But happens only once in a few days for me...
>
>When X is shut down, text console works ok.

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
