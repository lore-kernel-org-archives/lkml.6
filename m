Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCTV5j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:57:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42026 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeCTV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:57:34 -0400
X-Google-Smtp-Source: AG47ELtc2bUquzp1qXXnfwTtbLjoPV80F7eGlCSleWCFezpkETwXbkRlcIxfkUAzIb7M3IbkLy5vZw==
Date: Tue, 20 Mar 2018 14:57:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
Message-ID: <20180320215731.GA29962@roeck-us.net>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
 <e92c5457-20fd-1e6e-ab59-5ff53e647e89@roeck-us.net>
 <23103b1d-8f33-7885-379b-384382953a42@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23103b1d-8f33-7885-379b-384382953a42@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:48:40PM +0100, Peter Rosin wrote:
> On 2018-03-20 14:20, Guenter Roeck wrote:
> > On 03/20/2018 02:31 AM, Peter Rosin wrote:
> >> +static int pca9541_mybus(int ctl)
> > 
> > bool ?
> > 
> >> +{
> >> +	if (!(ctl & PCA9541_MYBUS))
> >> +		return 1;
> > 
> > true ?
> > 
> >> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
> >> +}
> >> +
> >> +static int pca9541_busoff(int ctl)
> > 
> > bool ?
> > 
> >> +{
> >> +	if (!(ctl & PCA9541_BUSON))
> >> +		return 1;
> > 
> > true ?
> 
> bool? true? Isn't that C++? Sigh, but you're right, and old habits
> die hard...
> 
> Would it be ok to add your reviewed-by tag as I fix that?
> 
Sure.

Guenter

> Cheers,
> Peter
