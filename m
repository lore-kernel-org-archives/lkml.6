Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4117237-1524820867-2-1018097081030883572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524820866; b=dAzQz/1S1jO8lev37W4T17dvizfDg1a1Ciw26I1Oaf5l3An8LJ
    HiGL5fg/GH6vLxYHma7VBx1kiPy63lTgWkz38+L+9W0WfD7q7WdmLJ8kJ9Cb0TOp
    TcJm+o8/obEJ0migjBDyDttYtOTpON+rIasO4wE0XpnoYuA+hcXLuLP1CNgVvbv6
    ZjwnnWvBffAG4iu/cWSOm6iuofkQselVKbeU1KJ9KRAGQBDmLBXt8GTjrHS89FTp
    dN3UOeSgtQW9AV23SNbk1UvdiP0Au83aV59ozLfuQcz2nUbTTqMFbmgIg0frrdcX
    +/6x9Yr7VkBq35aqVlGkREtwfYki8HIjMJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1524820866; bh=hhJcF7kM1lkztjqeX8cqPEXBrubpHWS8PSU5g0tNgE
    o=; b=jEGX0TxmKZfaNVHeqX/NSx299uupu7GOaiy05M8mJ00ZeMTWqBfi6lU0qe
    apimqb1S/RCz9MaWW9dVIyeZNRh/pdPTviSafZpywnIia9LB9KwYh1RyeeQGvxmR
    4mjgNK4c04IrME0hyzJyVoIv69PSGEqzIGKrdk8k8xFfYaJlZwbLmrIs7zTJmXhp
    ZSkwlIofthEcCyGzSJwDPx6lfUuiJm3y/g8kPc8W0Xozvn370RHgsD6A+01sPMCl
    t2YbAra5gvuNoKqrOCknjAr4gGznXdSWX/uYDSHRQw8+kn8jrWCxFZQ4ARdimq8V
    tbplROvpzeZirTQPz5vlmpk8i81g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBlPLJAfPzNQBp7K3Ok/MFjj5MA6M7hml7jrtbNwp+wAhR7kCT7RBXabR0J2iNSJxzU4ZDjsgKcyIhdTJpnArIoHbTr6HUk0HfS16cjM+4A+McRq1D5V
    G2nhm19utzqf5r6VILc9zLch0tWYmUsthx4e8X96ZA8RgVpsRiC7inHUsEqwmxFLf/DShodf0pmNvH52epFmhudgylElX9ivJ2zpPruenZC6U8oP7Fesqzsr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=ZPYY-pVbU6T3_nGgPo8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757657AbeD0JVD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 05:21:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:13200 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757621AbeD0JVC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 05:21:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,334,1520924400";
   d="scan'208";a="50403233"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>,
        "Botello Ortega\, Luis" <luis.botello.ortega@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Srivatsa\, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "Martinez Monroy\, Elio" <elio.martinez.monroy@intel.com>,
        "Vega\, Ricardo" <ricardo.vega@intel.com>, airlied@linux.ie,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Wajdeczko\, Michal" <Michal.Wajdeczko@intel.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
In-Reply-To: <CAFXWsS8H8V3RvArLnvGF1z_TuojgBU6pDoqBccCHGV=s9DNJfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com> <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com> <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com> <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com> <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com> <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com> <CAFXWsS87X_QVFSA+BqefknE4x0o=7Edfp1iqdTD81YCcoLHsmQ@mail.gmail.com> <CAFXWsS8H8V3RvArLnvGF1z_TuojgBU6pDoqBccCHGV=s9DNJfA@mail.gmail.com>
Date: Fri, 27 Apr 2018 12:20:55 +0300
Message-ID: <87zi1pt37s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
> Can I ask if this is on anyone's radar as I'm concerned this patch will
> stall otherwise?

Pushed to drm-intel-next-queued, thanks for the patch.

I opted to drop the Cc: stable for now. This doesn't mean it can't be
backported later on, I'm just punting on that call right now to make
some forward progress here.

Joonas, please do pick f6d3e06f0747 ("drm/i915/glk: Add MODULE_FIRMWARE
for Geminilake") to drm-intel-fixes to queue it to v4.17.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
