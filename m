Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeERQfP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:35:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37660 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeERQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:35:12 -0400
X-Google-Smtp-Source: AB8JxZr8QMPuafxEltrj3uoyrOMPAyAmy3jDo9LyJ4gkWvUt4Je1nTxsrmx7zaYeiwJtT46vo7wZ+A==
Date: Fri, 18 May 2018 11:35:10 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 2/4] rtc: ds1307: support m41t11 variant
Message-ID: <20180518163510.GA12620@rob-hp-laptop>
References: <20180516210842.5874-1-giulio.benetti@micronovasrl.com>
 <20180516210842.5874-2-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516210842.5874-2-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:08:40PM +0200, Giulio Benetti wrote:
> The m41t11 variant is very similar to the already supported m41t00 and
> m41t0, but it has also 56 bytes of NVRAM.
> 
> Add it to driver taking into account NVRAM section.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +
>  drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
