Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtHpn1JTXbALNSVCCMZ+pNUds5CoGZpaFGWr01RUj3zemC+wZ2Vw2j0hWS3xIV/0CGmyOeS
ARC-Seal: i=1; a=rsa-sha256; t=1520687504; cv=none;
        d=google.com; s=arc-20160816;
        b=knrbZr+eMse9mrbERDZASrpEvmX1zPW7YWuwr+stuaDAgyK6v3v6zoJ5vmCz9ckg/e
         HeTT7im1VvvGTFXtdclPpL9jbb+hogVIiYWx7ghL/ZXF4NwA/eUh57ce+OXzta0b+RQ0
         971rH0GU8pPEVT4LCQeBGfpcxfDuyLaHb8q1LCryr7mX9T7iCEpYuFW01g1Q2SiM9h8A
         nBkjvTXMYCjY2D2p/VJcSs8EfCxQA2pQIcojX/aMj4lFGgOeJj64xGVZGHSxZF6XQfbd
         z/n0/W7l++GC0T8zyH4Eo4oWboUqX5YaZoxGJ0kpIrMYq+BeYB858Dj/7L8Ut1G+DVAY
         /+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=CqD4Ph8z5EdRqw8LrKfXMYOXj3Qeddqviak4ND2Ii9M=;
        b=o3J/E6peG/a0/IlDsWInBhuvIAa0DLWYPVcKkzZT6sTJEllCYiXFpJUOiaTV2myK95
         R9VK6cGFUB2/H0EPiVnBeeFpORjyYCjuJD7Ccgv+gmKjfaITwIqV1PNtHPbK6N+RiGdd
         ecSDeehPCdpxoEGopekH8SD1MCpK7x9e7REZmhlPN87Kxfz5Z+RcBkYFkVmIpNGu+2z7
         dLQR26c729Qx856K57/hYi8aYX5pzDm0yO3MbWCPZUi1l2OUswDsiKuhg3hraCE186yW
         G9mDqlY9VLoquA+DFCnhJ6WRqzIzbZsh4yqmRznjiqBdNMTM8A38KaHWV2APytqE5KKw
         hVQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="scan'208";a="210405050"
Message-ID: <1afb789425c50f06efbd80bc7377731fd1269d42.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: J Freyensee <why2jjj.linux@gmail.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann
 <arnd@arndb.de>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open
 list <linux-kernel@vger.kernel.org>
Date: Sat, 10 Mar 2018 15:11:35 +0200
In-Reply-To: <3f3f9059-06ae-cb78-0d02-2658b2edc234@gmail.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
	 <3f3f9059-06ae-cb78-0d02-2658b2edc234@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594556420631043785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 13:47 -0800, J Freyensee wrote:
> Looks better :-).
> 
> 
> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

Thank you.

/Jarkko
