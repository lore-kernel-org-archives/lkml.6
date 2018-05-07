Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEGOL5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:11:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46244 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeEGOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:11:54 -0400
X-Google-Smtp-Source: AB8JxZqsedIK1WCbkPHf/qcKJickLyniMECAAM+mAaqQiSFNnnfqoUTbbjvUJkgfUcHcvwww0oME8A==
Date: Mon, 7 May 2018 09:11:52 -0500
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Nick Milner <nick.milner@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: devfreq: rk3399_dmc: improve binding
 documentation.
Message-ID: <20180507141152.GA28712@rob-hp-laptop>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
 <20180505093450.17327-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505093450.17327-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:34:46AM +0200, Enric Balletbo i Serra wrote:
> From: Nick Milner <nick.milner@collabora.com>
> 
> There are several typos, references to non existent files, grammar and
> punctuation mistakes in the rk3399_dmc.txt binding. This patch tries
> to improve the binding documentation and fix these mistakes.
> 
> Signed-off-by: Nick Milner <nick.milner@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - [1/6] Add Acked-by MyungJoo Ham.
> - [6/6] Removed this patch from this series.
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 207 +++++++++---------
>  1 file changed, 105 insertions(+), 102 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
