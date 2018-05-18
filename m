Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeERQeM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:34:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35941 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeERQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:34:10 -0400
X-Google-Smtp-Source: AB8JxZo3XcluRCGmaxGUFlp8DZ8E7kAKO4yDcX2SBfDOcsigspxTu2GpOvEy7Rg9I9WhXs1Bm2VjQg==
Date: Fri, 18 May 2018 11:34:08 -0500
From: Rob Herring <robh@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: jic23@kernel.org, benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 8/9] counter: stm32-lptimer: add counter device
Message-ID: <20180518163408.GA6430@rob-hp-laptop>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <726de278f09aa4438b97b147cd26a03009522997.1526487615.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726de278f09aa4438b97b147cd26a03009522997.1526487615.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:52:27PM -0400, William Breathitt Gray wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Add support for new counter device to stm32-lptimer.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../{iio => }/counter/stm32-lptimer-cnt.txt   |   0
>  .../devicetree/bindings/mfd/stm32-lptimer.txt |   2 +-

Please split bindings to separate patch.

>  drivers/counter/Kconfig                       |  10 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/stm32-lptimer-cnt.c           | 722 ++++++++++++++++++
>  drivers/iio/counter/Kconfig                   |   9 -
>  drivers/iio/counter/Makefile                  |   2 -
>  drivers/iio/counter/stm32-lptimer-cnt.c       | 382 ---------
>  8 files changed, 734 insertions(+), 394 deletions(-)
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
>  create mode 100644 drivers/counter/stm32-lptimer-cnt.c
>  delete mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c
