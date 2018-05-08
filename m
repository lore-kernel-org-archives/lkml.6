Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AB8JxZr09/oWenqIQtbVhIMX91yW68iUnIQ5HZjCHFWEo8339hptVdoW2qE0X/RbiivLGt8B/R0G
ARC-Seal: i=1; a=rsa-sha256; t=1525795200; cv=none;
        d=google.com; s=arc-20160816;
        b=tM2Tr2tzRzxtfSxKsh8Qvmq7fQ028mq/ol0NkRi48KBzJt0qp9PN2IloxAYiRghhxV
         tXJCNycu7VJRE/BUcoygM57VGXwoMGc5SOsjP+Q3C0xEWBmj0WVdTVeROksSL1WUxLgY
         IoMClt6Li6OKdAZhDonBgvBhP3unbcKRuaKjPY6aJgR+crVVLrVAuxdji5DdcJoRJTvm
         DBtsvDCeDIbhY9v3mWK9ayVchj5ofxOz5RxCMQgUqdM0Z9+DW0S3FpFYLsLp/FLgQEHT
         J8yt5srLLxuloF7KOVf09j++S+ffCGa2o6RqdhCbnmBQgukup9AiC4vtMRETs2QUT2wG
         vzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=JdHFl8WqvMcukET/5Ft8ujrgpio/nU0yA1OzbZ1GSWQ=;
        b=hSZKHqQpJCMJUkbEhVVl3jufkg9Ki41OmX7nrmE2/Cr1byc6DcAgL1fZajnPt9ZRxM
         1BhKfYcgICX2jkW19gFfAJod3khJfgJgCyUilJrBEtwFXiAyK8zKN9bsnIz/aObbL2oH
         opxYTmGQ0eIhD7ZMPdW3FeXWQ3mY7ZAmo8EW09gYJOIs7Zk3Es4UiPJJbTuZjv9+RJf4
         EvJDR3WPm+bYuivHNJR983RuqrqZfruTijnZUIMfafsv68kPmcDarzObFFYDxh+ApXdf
         eCdVvm54NVDe/LrPOzh6Bnoqs421zjbY+rWGI6LZCJqT7yyaSaZk4Pa6AINV6oPsCPEw
         ip8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Tue, 8 May 2018 09:59:55 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho
 Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Vinod Koul
 <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <treding@nvidia.com>, Sanyog Kale <sanyog.r.kale@intel.com>,
 Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Sagar Dharia
 <sdharia@codeaurora.org>, Ingo Molnar <mingo@kernel.org>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Kees Cook <keescook@chromium.org>,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH 03/18] docs: */index.rst: Add newer documents to their
 respective index.rst
Message-ID: <20180508095955.64791a73@lwn.net>
In-Reply-To: <e6852448ac11e827f86dab1e183b82af6a320559.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
	<e6852448ac11e827f86dab1e183b82af6a320559.1525684985.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797480361597979?=
X-GMAIL-MSGID: =?utf-8?q?1599912228490884823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  7 May 2018 06:35:39 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> A number of new docs were added, but they're currently not on
> the index.rst from the session they're supposed to be, causing
> Sphinx warnings.
> 
> Add them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

I've applied this one, thanks.

jon
