Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425309AbeCBPw4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:52:56 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34792 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424377AbeCBPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:52:54 -0500
X-Google-Smtp-Source: AG47ELvzFFM6W9/J1zExvZH50jURoAd3TfHgRR8GONN4/WHuU/9z7Zz8A1LhRxgOinbvyX5fYSEW1w==
Date: Fri, 2 Mar 2018 09:52:51 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v1 19/19] arm: dts: mediatek: converted to using SPDX
 identifiers
Message-ID: <20180302155251.5h6xrum4cnot6pd6@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <8cdd049bef01b9b657e0804a7dba145520b9a1c5.1519378872.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cdd049bef01b9b657e0804a7dba145520b9a1c5.1519378872.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 06:16:39PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Convert boilerplate license statement into proper SPDX identifier style.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> ---
>  arch/arm/boot/dts/mt2701-evb.dts              |  9 +--------
>  arch/arm/boot/dts/mt2701.dtsi                 |  9 +--------
>  arch/arm/boot/dts/mt6323.dtsi                 |  8 +-------
>  arch/arm/boot/dts/mt6580-evbp1.dts            |  9 +--------
>  arch/arm/boot/dts/mt6580.dtsi                 |  9 +--------
>  arch/arm/boot/dts/mt6589-aquaris5.dts         | 10 +---------
>  arch/arm/boot/dts/mt6589.dtsi                 | 12 ++----------
>  arch/arm/boot/dts/mt6592-evb.dts              |  9 +--------
>  arch/arm/boot/dts/mt6592.dtsi                 |  9 +--------
>  arch/arm/boot/dts/mt7623.dtsi                 |  9 +--------
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  2 +-
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts        |  9 +--------
>  arch/arm/boot/dts/mt7623n-rfb.dtsi            |  9 +--------
>  arch/arm/boot/dts/mt8127-moose.dts            |  9 +--------
>  arch/arm/boot/dts/mt8127.dtsi                 |  9 +--------
>  arch/arm/boot/dts/mt8135-evbp1.dts            |  9 +--------
>  arch/arm/boot/dts/mt8135.dtsi                 |  9 +--------
>  17 files changed, 18 insertions(+), 131 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
> index 63af4b1..be0edb3 100644
> --- a/arch/arm/boot/dts/mt2701-evb.dts
> +++ b/arch/arm/boot/dts/mt2701-evb.dts
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015 MediaTek Inc.
>   * Author: Erin Lo <erin.lo@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 9109a2b..0c8a17c1 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015 MediaTek Inc.
>   * Author: Erin.Lo <erin.lo@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/clock/mt2701-clk.h>
> diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
> index 44c5642..0ebc132 100644
> --- a/arch/arm/boot/dts/mt6323.dtsi
> +++ b/arch/arm/boot/dts/mt6323.dtsi
> @@ -1,15 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  &pwrap {
> diff --git a/arch/arm/boot/dts/mt6580-evbp1.dts b/arch/arm/boot/dts/mt6580-evbp1.dts
> index 17daeae..ca13789 100644
> --- a/arch/arm/boot/dts/mt6580-evbp1.dts
> +++ b/arch/arm/boot/dts/mt6580-evbp1.dts
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015 MediaTek Inc.
>   * Author: Mars.C <mars.cheng@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
> index a349dba..2bdc5ed 100644
> --- a/arch/arm/boot/dts/mt6580.dtsi
> +++ b/arch/arm/boot/dts/mt6580.dtsi
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015 MediaTek Inc.
>   * Author: Mars.C <mars.cheng@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mt6589-aquaris5.dts
> index 594a6f3..e31d5952 100644
> --- a/arch/arm/boot/dts/mt6589-aquaris5.dts
> +++ b/arch/arm/boot/dts/mt6589-aquaris5.dts
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MundoReader S.L.
>   * Author: Matthias Brugger <matthias.bgg@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.

You are changing the license from 2.0+ to 2.0.

> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
> index 41df742..b47b5e5 100644
> --- a/arch/arm/boot/dts/mt6589.dtsi
> +++ b/arch/arm/boot/dts/mt6589.dtsi
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MundoReader S.L.
>   * Author: Matthias Brugger <matthias.bgg@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.

ditto

> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +*/
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mt6592-evb.dts
> index b57237e..02849f6 100644
> --- a/arch/arm/boot/dts/mt6592-evb.dts
> +++ b/arch/arm/boot/dts/mt6592-evb.dts
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Howard Chen <ibanezchen@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
> index c69201f..8696ac8 100644
> --- a/arch/arm/boot/dts/mt6592.dtsi
> +++ b/arch/arm/boot/dts/mt6592.dtsi
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Howard Chen <ibanezchen@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index bf9db44..1e1c60a 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -1,16 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 3e8d02c..204c2be 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -1,7 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This probably can't really be MIT because other files included are GPL 
only and this file is not too useful on its own. But as copyright 
holder, you could change it (that should be a separate commit).

>  /*
>   * Copyright 2017-2018 Sean Wang <sean.wang@mediatek.com>
>   *
> - * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> index 05f1171..61930f2 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> @@ -1,16 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> index 07ed15d..6609f50 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> +++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> @@ -1,16 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2017-2018 MediaTek Inc.
>   * Author: John Crispin <john@phrozen.org>
>   *	   Sean Wang <sean.wang@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt8127-moose.dts b/arch/arm/boot/dts/mt8127-moose.dts
> index 073e295..308829b 100644
> --- a/arch/arm/boot/dts/mt8127-moose.dts
> +++ b/arch/arm/boot/dts/mt8127-moose.dts
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Joe.C <yingjoe.chen@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
> index 916c095..3adfc6f 100644
> --- a/arch/arm/boot/dts/mt8127.dtsi
> +++ b/arch/arm/boot/dts/mt8127.dtsi
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Joe.C <yingjoe.chen@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
> index 460db6d..0ace7a4 100644
> --- a/arch/arm/boot/dts/mt8135-evbp1.dts
> +++ b/arch/arm/boot/dts/mt8135-evbp1.dts
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Joe.C <yingjoe.chen@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index a97b4ee..688069d 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -1,15 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
>   * Author: Joe.C <yingjoe.chen@mediatek.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <dt-bindings/clock/mt8135-clk.h>
> -- 
> 2.7.4
> 
