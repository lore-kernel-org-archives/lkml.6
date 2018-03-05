Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeCEW4r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:56:47 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39291 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeCEW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:56:46 -0500
X-Google-Smtp-Source: AG47ELueHcexqOAgCQSX8tmVgkbD2ij8P76f7cQCVnvGH+NaU+in9miOz9xKVB8lOVy1lSNh+0uK0g==
Date: Mon, 5 Mar 2018 16:56:44 -0600
From: Rob Herring <robh@kernel.org>
To: Pierre Bourdon <delroth@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: light: Add bh1730fvc bindings
Message-ID: <20180305225644.npkvx6nubyiuqcor@rob-hp-laptop>
References: <20180228001525.96044-1-delroth@google.com>
 <20180228001525.96044-2-delroth@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228001525.96044-2-delroth@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:15:25AM +0100, Pierre Bourdon wrote:
> Signed-off-by: Pierre Bourdon <delroth@google.com>
> ---
>  .../devicetree/bindings/iio/light/bh1730.txt      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1730.txt

Reviewed-by: Rob Herring <robh@kernel.org>
