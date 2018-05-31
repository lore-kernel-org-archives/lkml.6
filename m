Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbeEaQcD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:32:03 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35914 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932139AbeEaQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:32:01 -0400
X-Google-Smtp-Source: ADUXVKI+KNZblO51QtMeL8dxrjWz6PpoxdQ7DVHSMTJCc/rmW+goE8nfFoyroXF+BLmRneQ1Nne3Jw==
Date: Thu, 31 May 2018 11:31:59 -0500
From: Rob Herring <robh@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 10/11] dt-bindings: misc: add bindings for throttler
Message-ID: <20180531163159.GA4369@rob-hp-laptop>
References: <20180525203043.249193-1-mka@chromium.org>
 <20180525203043.249193-11-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525203043.249193-11-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:30:42PM -0700, Matthias Kaehlcke wrote:

Commit msg?

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/misc/throttler.txt    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
> new file mode 100644
> index 000000000000..92f13e94451a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/throttler.txt
> @@ -0,0 +1,41 @@
> +Throttler driver
> +
> +The Throttler is used for non-thermal throttling of system components like
> +CPUs or devfreq devices.

This all looks very Linux specific and not a h/w device. Perhaps you can 
add hint properties to OPP tables as to what entries can be used for 
throttling, but otherwise this doesn't belong in DT.
