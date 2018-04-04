Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeDDLSp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:18:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDLSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:18:44 -0400
Date: Wed, 4 Apr 2018 13:18:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <DavidWang@zhaoxin.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bruce Chang (VAS)" <BruceChang@via-alliance.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        Benjamin Pan <BenjaminPan@viatech.com>, Luke Lin <LukeLin@viacpu.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= 1/2] x86/mce: new
 centaur CPUs support MCE broadcasting
Message-ID: <20180404111822.GA16437@pd.tnic>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
 <1522403622-31146-2-git-send-email-davidwang@zhaoxin.com>
 <20180330102621.GA30063@pd.tnic>
 <0e48bb8d5dda4c8fbff849a052714524@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e48bb8d5dda4c8fbff849a052714524@zhaoxin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 02:34:52AM +0000, David Wang wrote:
> Those are new processors and main usage of CentaurHauls CPUs in recent
> years is for limited and/or embedded instead of distribution markets.
> So there is no plan or resource to create such document for public
> access. Is public spec mandatory for code check-in? We can provide
> platforms for verification instead.

Nah, not needed. As long as the code paths don't break anything else and
as long as we can CC you to fix bugs people report, we're good. :-)

Btw, please do not top-post on a public ML.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
