Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBICjT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:39:19 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40851 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBICjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:39:17 -0500
X-Google-Smtp-Source: AH8x224rvtW86oKcxh9Rt5OXBumV+N0mC+q88hlWAHJhRVn+d9KvdJm3EA6bV1WwIG2XfBDSIIOWpw==
Date: Thu, 8 Feb 2018 20:39:15 -0600
From: Rob Herring <robh@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 8/8] ASoC: samsung,tm2-audio DT binding documentation
 update
Message-ID: <20180209023915.puuuzou5gdwrxzcq@rob-hp-laptop>
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
 <CGME20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489@epcas1p1.samsung.com>
 <20180205154403.13520-9-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205154403.13520-9-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:44:03PM +0100, Sylwester Nawrocki wrote:
> This patch documents additional entries of the audio-codec and
> i2s-controller properties required for the HDMI audio support.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/sound/samsung,tm2-audio.txt        | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
