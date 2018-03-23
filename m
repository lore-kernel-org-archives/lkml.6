Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCWPWB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:22:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCWPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:22:00 -0400
Date: Fri, 23 Mar 2018 16:21:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/21] eeprom: at24: arrange local variables
Message-ID: <20180323152157.GA6934@kroah.com>
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319091721.18193-4-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:17:03AM +0100, Bartosz Golaszewski wrote:
> Arrange declarations of local variables by line length as visually
> it's easier to read.

That's the craziest thing I've seen in a while...

ok, if it makes it easier for you :)

greg k-h
