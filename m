Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeCMKgK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:36:10 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41009 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932489AbeCMKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:36:06 -0400
X-Google-Smtp-Source: AG47ELsaLl2XZCRuEh3GqIwgepghcGQHypTXCIlyBlgCg5soZ2BqZmav5qY48SwFK9NzNBwCSr/4Sg==
Message-ID: <1520937363.4264.47.camel@baylibre.com>
Subject: Re: [PATCH] drm/meson: Add support for DMT modes on HDMI
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 11:36:03 +0100
In-Reply-To: <1520935670-14187-1-git-send-email-narmstrong@baylibre.com>
References: <1520935670-14187-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 11:07 +0100, Neil Armstrong wrote:
> This patch adds support for DMT display modes over HDMI.
> The modes timings configurations are from the Amlogic Vendor linux tree
> and tested over multiples monitors.
> Previously only a selected number of CEA modes were supported.
> 
> Only these following modes are supported with these changes:
> - 640x480@60Hz
> - 800x600@60Hz
> - 1024x768@60Hz
> - 1152x864@75Hz
> - 1280x1024@60Hz
> - 1600x1200@60Hz
> - 1920x1080@60Hz
> 
> The associated code to handle the clock rates is also added.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Looks good to me

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
