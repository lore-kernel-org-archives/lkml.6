Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeCLJ0n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:26:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42959 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:26:41 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: David Wang <DavidWang@zhaoxin.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@kernel.org" <linux-pm@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bruce Chang (VAS)" <BruceChang@via-alliance.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        Benjamin Pan <BenjaminPan@viatech.com>, Luke Lin <LukeLin@viacpu.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Jiangbo Wang(BJ-RD)" <JiangboWang@zhaoxin.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH] Delete some unusefull operations for centaur CPU/platform
Date: Mon, 12 Mar 2018 10:27:18 +0100
Message-ID: <1792259.nnz4czxE5K@aspire.rjw.lan>
In-Reply-To: <20180312084033.lignixrpg4ruoxbq@gmail.com>
References: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com> <efc93496e4ba46958b7b09eff54c2ce2@zhaoxin.com> <20180312084033.lignixrpg4ruoxbq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 12, 2018 9:40:33 AM CET Ingo Molnar wrote:
> 
> * David Wang <DavidWang@zhaoxin.com> wrote:
> 
> > [David] pr->flags.has_cst means BIOS define valid C state table.  And at lease 
> > define 2 entries. On all centaur platform which support C3, this condition is 
> > always true.
> 
> > [David] Just as the following comment said, we need not execute WBINVD and 
> > ARB_DISABLE/ARB_ENABLE when entering C3 if bm_check=1 and bm_control=0.  This 
> > logic is valid for all platform not only for Centaur, I think.
> 
> Ok, fair enough!

Well, I still have this one queued up as cpuidle material.

I can drop it if you want to take it instead.

Thanks,
Rafael
