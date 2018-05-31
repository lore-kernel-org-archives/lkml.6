Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeEaDiV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:38:21 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36048 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932653AbeEaDiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:38:17 -0400
X-Google-Smtp-Source: ADUXVKJMH6nU9BcN9WpUappl3T1XUatMTw0XIMcJxDQ1P4BaNstLdzqkWQU1deJc+iFEo2ZJz3vd2g==
Date: Wed, 30 May 2018 22:38:14 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Mark Rutland <mark.rutland@arm.com>, limor@ladyada.net,
        Nitin Patil <nitin@mindsensors.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: Add vendor prefix for Adafruit
Message-ID: <20180531033814.GA31055@rob-hp-laptop>
References: <20180525193623.15533-1-david@lechnology.com>
 <20180525193623.15533-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525193623.15533-3-david@lechnology.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 02:36:21PM -0500, David Lechner wrote:
> This adds a device tree vendor prefix for Adafruit Industries, LLC.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
