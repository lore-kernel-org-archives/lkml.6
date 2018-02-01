Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeBADqJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 22:46:09 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:36989 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBADqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 22:46:05 -0500
X-Google-Smtp-Source: AH8x2241A7KRZzgnHpOn3byvBtAUZ+LaXagmOZw2cubaenNpNSo7XqSkpVn/HjuOcLzsQYP1COD3iK1rCm0iPLpebXg=
MIME-Version: 1.0
In-Reply-To: <20180201034507.GZ18649@localhost>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <20180129044801.GL18649@localhost> <CAOh2x=naBBc-Os=+yFocc3fTri2pebMqdR4=qN+vpHrD0gvunQ@mail.gmail.com>
 <20180201034507.GZ18649@localhost>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 1 Feb 2018 09:16:04 +0530
X-Google-Sender-Auth: dBJtgLXDpkrRhrJSbJ6P5GnEWhw
Message-ID: <CAOh2x=kE4uKYnVs0tWnjBHk0t=BQp+=otr89+NHZ0m2GWbNRrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: dmatest: change symbolic permissions to
 octal values
To: Vinod Koul <vinod.koul@intel.com>
Cc: Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 9:15 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> Right but lets no go changing to octals everywhere, new code sure :)
> I don't see plans to remove representations entirely from kernel yet.

Sure. I was just pointing out to the discussion where the *preferred* thing
happened.
