Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeAaKBv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:01:51 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55212 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeAaKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:01:49 -0500
X-Google-Smtp-Source: AH8x226qZdiYLsV+EtZnWmzMM9NcoW85cjxzMpUjSyfeRMxzeUe14tRGoGWwE4LRJHALxVubrUtyUzhZZLXIFqQp0Tw=
MIME-Version: 1.0
In-Reply-To: <20180129044801.GL18649@localhost>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com> <20180129044801.GL18649@localhost>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 31 Jan 2018 15:31:48 +0530
X-Google-Sender-Auth: rbi_4n8pqSr4IJwMZW9kQcc_LBE
Message-ID: <CAOh2x=naBBc-Os=+yFocc3fTri2pebMqdR4=qN+vpHrD0gvunQ@mail.gmail.com>
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

On Mon, Jan 29, 2018 at 10:18 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Jan 22, 2018 at 06:44:40PM +0800, Yang Shunyong wrote:
>> Current coding style prefers octal permissions values. This patch
>> changes symbolic permissions to octal values.
>
> Is this preference documented anywhere?

This is where it started.

lkml.kernel.org/r/CA+55aFzu59sXo7qA8CoCo+tSJgEkW7fWDjkt_tsTzPWZ7gxj1A@mail.gmail.com
