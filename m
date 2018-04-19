Date: Thu, 19 Apr 2018 09:45:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
	khalid.aziz@oracle.com, shannon.nelson@oracle.com,
	anthony.yznaga@oracle.com
Subject: Re: [PATCH 1/2] char: sparc64: Add privileged ADI driver
Message-ID: <20180419074536.GA20145@kroah.com>
References: <20180418162958.442909-1-tom.hromatka@oracle.com>
 <20180418162958.442909-2-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418162958.442909-2-tom.hromatka@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 10:29:57AM -0600, Tom Hromatka wrote:
> +/*
> + * Copyright (c) 2017, 2018, Oracle and/or its affiliates. All rights reserved.
> + * Author: Tom Hromatka <tom.hromatka@oracle.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2
> + * as published by the Free Softare Foundation; or, when distributed
> + * separately from the Linux kernel or incorporated into other
> + * software packages, subject to the following license:
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this source file (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + */

Please just use a single SPDX line at the top of the file for this huge
license boiler-plate.

thanks,

greg k-h
