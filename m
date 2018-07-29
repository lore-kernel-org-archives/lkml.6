Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC75FF83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D7220873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D7220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeG2IZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 04:25:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:39213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeG2IZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 04:25:04 -0400
Received: from homer.simpson.net ([185.221.148.245]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1fiZ9T204S-001BNq; Sun, 29
 Jul 2018 08:55:31 +0200
Message-ID: <1532847330.1618.8.camel@gmx.de>
Subject: Re: candidates for @devel-rt localversion-rt++
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 29 Jul 2018 08:55:30 +0200
In-Reply-To: <1532768831.9882.71.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OTmwcwHUDhTSVbhETeRTU67/LjnleoPYCZu2tlHpO+YjUEdDkGz
 Ck6rA2YGkJXVB/iLPTZ3gFG5wFYfpTdMDG7nU4IsI35rXRP1AVXjDQd21zTg3GSR3ba2eRB
 DNxb0u2u9ZVwR+xVlL7jphWvlWt+GwYTVQ9Vt1Pu0e6IG0Yx5MeJK0ohAOnyobTAblnemou
 fbtJJEIGck+3BJAKPBIRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MdPH4tXHdlQ=:8mrsax54klX324mXriPsVy
 UCRz9BnAXB15I3cip2iRg+01WzrPXqee345xK3e4UQdOCBBj/gsBxMN86RJ1P/fOiJSMoSnsQ
 VFlI9Xjzke5kwEkHPF8oFac95PM4JZyUQ6pPX44QC06RMh9bOhCbaNHcj6J5k+H+B3sbpSmoo
 CdnOzylCghEU0XuNXA2v4yha02RNLEw6/jt8DiePz98bo5pwZLExpEanqkaVlw3YaVJZzh0bT
 p4S540mai3szHZdEbT86oIniuBnvu68HPdYRXyGGXnWuRnpf6XhobK/wmq+tZX0NjXVZhTgNn
 Yr+IPeVrUqY7/JuNTyk5p6+jo4Gux6eVvSHtY7TDT02AXw2hJpQzjkE97Y7ZglkwrtnGcs8rG
 a1Zv0Vj9PMgES+iulrFUygm/JZMDKYApAz9+4FciiJzSiBOrNamY0P2u5BSt6qMH9gijvxBgk
 SRm5RMOT37dk6+Xu/z7fe+Eci6GFMckYuPgX+XWJRUyag8IzI4YDIZ0SPrFKF8LoMZGVTuKOW
 vnQH57vqk/IyU0V4pjdDf8aOpvWtc03xINNud+IvRZyh93oAADxPHoYxCVzHTa9gzpryaMiAd
 RK2aclR9PL/mpYvr99a+8FKh3dSSjrmTP6/6aIjhJNrkQrsB5afMTLMHwoedbfYboT9/yoXLH
 /aj/qzWmioFcdwJ8sm94rXIiKPkl6GS4dF50LVcb+qkWdqAIeiY703ebhrNsVXff1TOcn5w11
 vKlinZJXtFLwdzg/QDlldJTmMQILNi4KpX9daPyra3RylnDYeoEArDFGU+2WfA8MKsC7D/yAx
 BcnFlJl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-28 at 11:07 +0200, Mike Galbraith wrote:
> 1. arm64/acpi/perf: move pmu allocation to an early CPU up hook

Nope, it's an ex-candidate.  Having found/run kvm unit tests, I
discovered that while the above fixes boot time splat, it somehow
manages to break kvm pmu tests, so needs staring at.

	-Mike
