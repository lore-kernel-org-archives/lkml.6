Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeBSUsC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:48:02 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44034 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeBSUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:48:00 -0500
X-Google-Smtp-Source: AH8x227JLco0uVxQ/+5uBILWsV9jC2Cv+uBkgbw3kokuBOLz/UozfwSBs3jO5GSWc+rGkXNp46a+ew==
Date: Mon, 19 Feb 2018 14:47:59 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: Add DT bindings documentation for max9759
 amplifier
Message-ID: <20180219204759.aofqbmmxc7sys2wc@rob-hp-laptop>
References: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
 <1519047958-22583-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519047958-22583-2-git-send-email-narmstrong@baylibre.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:45:57PM +0100, Neil Armstrong wrote:
> This patch adds DT bindings documentation for Maxim MAX9759
> speaker amplifier.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

Reviewed-by: Rob Herring <robh@kernel.org>
