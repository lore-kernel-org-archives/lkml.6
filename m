Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeDYMDL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:03:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46767 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeDYMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:03:09 -0400
X-Google-Smtp-Source: AIpwx4/XPGtyVNwN5TRT+FUmTVcv5R2j/kvUEaC0w4LaxpOht+IklRErSWtsh0q6BOJgbm/UeL98Tw==
Message-ID: <1524657786.4026.63.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: meson: gxbb: add the video decoder clocks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mike Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 25 Apr 2018 14:03:06 +0200
In-Reply-To: <20180424184838.3406-3-maxi.jourdan@wanadoo.fr>
References: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
         <20180424184838.3406-3-maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 20:48 +0200, Maxime Jourdan wrote:
> Add the SEL/DIV/GATE for VDEC_1 and VDEC_HEVC.
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>

Applied to next/drivers
Thx
