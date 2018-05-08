Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AB8JxZqu8shhpbS79/z5Q9DCUoXf206rPSzS+XvXcyWYFqBNoPO93HnsSAEtJUjAi3nmcGP/94EQ
ARC-Seal: i=1; a=rsa-sha256; t=1525795864; cv=none;
        d=google.com; s=arc-20160816;
        b=mbD2cZa2pHSuWql/AEZmGFC6h0AIfuf8TqC0kHyd2QtgOrq8qRPg5KHwdySyd7YyLf
         fiBYte8XPGMXnFtX3MtPaiDG3NxUHfPfBDJ7fd5bishB0ofX6LkrwuhVO+m0ZXPRI5QZ
         NkLhSYXEvqLRq2NbBMsPdBym0i/ydfZMxDcTqBDLtqTTwirAT3NOTzoNJzp9kscrSBCt
         aYWBFGA9+Bdf0uVV7TIhZYhkKcoF0CQe0ImyUS+ynz3wFMYlHptTNyq4t57s741p+3mb
         cFiOMeg3ww3nmq9d44tmb1BNvXAICqYL1SlwzOgk8AYl/Z4k84WF3W8HRrKT/fE3agQb
         sWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=2XmXDAuQa90+27VuHtXwzAF79xwLGGjnTH0pG1M+8Kk=;
        b=Y40iz793ap1RPuO46TpZkz9rXq2r0xVuKtHjTMm1bc0Mhd/KLrKh8YNcDs8LLFWbdZ
         F1lQCUUcGobRStHKDclZpvYRQinDlOXZrNa37vfqfqUqnI0yMIHkDjMT+HWZTU63X0Dv
         aSnAtqvPuUwFn7IqYQv2Ss+WNOIgUXIwVufyFvBGYeV4XiHxR3E9bwDAgnuuy5jQXEJe
         KyhVz6We/UloqMQw/62zlqZ3aO1fuwYgz7OefExfJ81gJRJGrUYAMNgWBekeMd51/hk5
         rxLFddadbog77C3dyYTqJJs0TX5xmwBFy/Z9hQP7ohV7mLwuoQENKikHlL+hc4Re4/KY
         HYeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Tue, 8 May 2018 10:10:59 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho
 Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall
 <cdall@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Marc
 Zyngier <marc.zyngier@arm.com>, Kai-Heng Feng
 <kai.heng.feng@canonical.com>, Thymo van Beers <thymovanbeers@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Rientjes <rientjes@google.com>, Linus
 Walleij <linus.walleij@linaro.org>, Vinod Koul <vinod.koul@intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia
 <sdharia@codeaurora.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Jonathan
 =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Thierry Reding
 <treding@nvidia.com>
Subject: Re: [PATCH 08/18] docs: driver-api: add clk documentation
Message-ID: <20180508101059.44ecdbd1@lwn.net>
In-Reply-To: <f3398bca6fba979bd55b8a053b6b46fe35bf9891.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
	<f3398bca6fba979bd55b8a053b6b46fe35bf9891.1525684985.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797477086317378?=
X-GMAIL-MSGID: =?utf-8?q?1599912924728839063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  7 May 2018 06:35:44 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> The clk.rst is already in ReST format. So, move it to the
> driver-api guide, where it belongs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
