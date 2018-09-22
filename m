Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A85C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCAB2154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCAB2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIVP41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:56:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIVP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:56:27 -0400
Received: from null ([172.19.249.173]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPXxi-1gP9bl1vd4-00Mdyl; Sat, 22
 Sep 2018 12:02:59 +0200
Date:   Sat, 22 Sep 2018 12:02:58 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <922221777.222442.1537610578773@email.1und1.de>
In-Reply-To: <20180921195601.8776-1-tuomas.tynkkynen@iki.fi>
References: <20180921195601.8776-1-tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH] staging: vc04_services: Remove unused vchiq_genversion
 script
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:B3jGny3EGKVAC+ctJO+EILmn4yNm84xPHXa2/mO2s/AfiunjQtC
 p6X8r3nEj3DXvdxl3WphwSGDBzuboNw+ApIHT2z0M/5SeD8r/9QHLakJEocTpv3/U9sSLd1
 g+3sKO1Y7RbGPLKS9H0HIYO2YvPgW/EDovxEfaFYpgOVf7X/pDflAZrN2a3wBnelw9as6cF
 UB/OOjA8u/Y3D+s2Q+bpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lxkTukdHgX8=:LqRl9meCMqmH2SeyBw7r+e
 9Umj9FCvywddndSWC8Fjb8caW5qM5h6/0AZXwYi8wkMXtbhXHR6E8jcb3M2RmHBKEAlw/RpIa
 kpG910kcZCXVMusxhWRI6zb50kFJdzgYsEjHAZ/YsxE2v8k9K7+vlEQsfqhGNrK+GdEwPg+vm
 KYo2r0U3iJGAKst3PwOPDH9Mkobb3euL4E7VHEUHsw5rdlGc235AHagpmqcmOCc/YqPRtiYcA
 S+N7DGhSYox9VObohqz4WgOGV39XPzbrfpaWx2//IOAC1wdmHftcGpsWDkzivzpfqcW4o+QwG
 +g4MCNIQU2yEzo1asaBw+XIoxkG2lZ3oaFpb5ot3cYI0TOWi3c02RY9AKUmNrYN2YTYcbX5U/
 0ZIdMqMNTlfrToFWY6+GkDo3yrm/877Hc+7+R4O1LhmIpcFjYMk1HBFdVy9HTO4VIuFzeduG4
 7u8ocbqwoL+qg/SJTH9DO1Ojzv0zTimYGQ1AgVVenWxSa/lcI0Dqn4I2e7mhR3giwyfnf7SXs
 MeS40B9d128u9aDEN3NtHjgqhZ+epwPCJl81GJ4o+OYcpEJjXk1cX+8Zv9r30fo2z1E2X8M5F
 ABkRq1Ed62pks7GANVJq4U/oBJOVHL4hckwc4obTnl0+z4p8u7UErTG7XrA/H/g8MyRUsl5hC
 u7JvS/oPrkulbgwU+5+aYGWbDP8we0VC6xKz5tQTlFIQT37i/3D4AZwW4VbxCwsLDTqFavN15
 nKPZAKkR6RJJAIvB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 21. September 2018 um 21:56 geschrieben:
> 
> 
> As far as I can tell, this has never been used.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
