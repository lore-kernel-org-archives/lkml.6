Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeEaGf5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbeEaGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:35:52 -0400
Date: Thu, 31 May 2018 08:35:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: valentina.manea.m@gmail.com, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: add test for USB over IP driver
Message-ID: <20180531063530.GB7744@kroah.com>
References: <20180531030057.32442-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531030057.32442-1-shuah@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 09:00:57PM -0600, Shuah Khan (Samsung OSG) wrote:
> Add test for USB over IP driver. This test runs several tests on a device
> specified in the -b <busid> argument and path to the usbip tools.
> 
> usbip_test.sh -b <busid> -p <usbip tools path>
> 
> e.g:
> cd tools/testing selftests/drivers/usb/usbip
> sudo ./usbip_test.sh -b 3-10.2 -p <yoursrctree>/tools/usb/usbip
> 
> This test should be run as root and user should build usbip tools before
> running the test.
> 
> The usbip test isn't included in the Kselftest run as it requires user to
> specify a device to run tests on.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

If you want to take this through your tree, that's fine with me:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Otherwise I will be glad to queue it up in mine, just let me know what
is easier for you.

Nice work, thanks.

greg k-h
