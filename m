Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeFEUSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:18:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45078 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeFEUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:18:36 -0400
X-Google-Smtp-Source: ADUXVKIXzpP62riuS0+mhEKf0QlmDfs+KR7WogLU61NctHWH5/B0r+8YMgucDKWSWGkxpGxCeRUD/A==
Date: Tue, 5 Jun 2018 14:18:32 -0600
From: Rob Herring <robh@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
Message-ID: <20180605201832.GA6966@rob-hp-laptop>
References: <20180602012900.181352-1-briannorris@chromium.org>
 <20180602012900.181352-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602012900.181352-2-briannorris@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:29:00PM -0700, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rhyland Klein <rklein@nvidia.com>
> ---
> v2: add Rhyland's Acked-by
> v3: no change
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
