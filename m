Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeBBT2F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:28:05 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44589 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeBBT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:27:56 -0500
X-Google-Smtp-Source: AH8x227pXIpuwk/5ODvhqqeM0PAP6rbu8P//VRHXQgrHo4UHBKIYYNoOEpr6fIga8pz/wvsUk7T1pQ==
Date: Fri, 2 Feb 2018 11:27:53 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: zhuoweizhang@yahoo.com
Cc: Jeremy McNicoll <jmcnicol@redhat.com>, jeremymc@redhat.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: angler: add pstore-ramoops support
Message-ID: <20180202192753.GH12728@builder>
References: <1514446709-19347-1-git-send-email-zhuoweizhang@yahoo.com>
 <20180112023354.GA16005@mini-rhel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112023354.GA16005@mini-rhel.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Jan 18:33 PST 2018, Jeremy McNicoll wrote:

> On Thu, Dec 28, 2017 at 02:38:29AM -0500, zhuoweizhang@yahoo.com wrote:
> > From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> > 
> > Support pstore-ramoops for retrieving kernel oops and panics after reboot.
> > 
> > The address and configs are taken from the downstream kernel's device tree.
> > 
> > Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>

Hi Zhuowei,

This patch looks good, but I'm unable to find the original patch in my
inbox, at lkml.org or at patchwork.kernel.org. Can you please resend the
original patch to linux-arm-msm@vger.kernel.org, with Kees' R-b and
Jeremy's A-b.

Regards,
Bjorn
