Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeCJAAE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:00:04 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43642 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbeCJAAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:00:02 -0500
X-Google-Smtp-Source: AG47ELsevabD59hnXAmwjgq2dDbOyyOv3cM19mNlOZ4GVc6opZN7r+oxZKOP9kUsQjzmm/MzABaTVA==
Date: Fri, 9 Mar 2018 17:59:37 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add various mcp4017/18/19
 potentiometers
Message-ID: <20180309235937.n66oofcqsp5zdfte@rob-hp-laptop>
References: <20180308195830.16348-1-peda@axentia.se>
 <20180308195830.16348-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308195830.16348-2-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 08:58:29PM +0100, Peter Rosin wrote:
> They come in 5 kOhm, 10 kOhm, 50 kOhm and 100 kOhm variations.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I've applied to avoid any conflicts.

Rob
