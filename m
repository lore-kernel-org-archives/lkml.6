Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeCZWYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:44 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38900 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeCZWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:38 -0400
X-Google-Smtp-Source: AG47ELvGenMybCm4jJanN/7LFXHoB6AOVx05LZRi0C405uRv0Om1PYxH8vNUf8+PUqikx8ONa2negw==
Date: Mon, 26 Mar 2018 17:24:36 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] dt-bindings: add micronova vendor prefix
Message-ID: <20180326222436.jgj6oc7l2swxs2uj@rob-hp-laptop>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-5-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521662593-25468-5-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:03:11PM +0100, Giulio Benetti wrote:
> This adds a vendor prefix "micronova" for Micronova srl
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
