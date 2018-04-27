Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759136AbeD0Tzx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:55:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40169 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758979AbeD0Tzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:55:51 -0400
X-Google-Smtp-Source: AB8JxZqaMSeXodpHH+i9qIa7f6F/UFiNvp5GMpNwAbzIlX3pwlsPMteeMixzE7PW5oMoXd4Nq3/l5Q==
Date: Fri, 27 Apr 2018 14:55:49 -0500
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
Subject: Re: [PATCH v2 1/5] dt-bindings: devfreq: rk3399_dmc: improve binding
 documentation.
Message-ID: <20180427195549.mk7zklh4nfli3qj2@rob-hp-laptop>
References: <20180424083742.14042-1-enric.balletbo@collabora.com>
 <20180424083742.14042-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424083742.14042-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:37:38AM +0200, Enric Balletbo i Serra wrote:
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
> Changes in v2:
> - [1/6] Add Acked-by MyungJoo Ham.
> - [6/6] Removed this patch from this series.
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 207 +++++++++---------
>  1 file changed, 105 insertions(+), 102 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
