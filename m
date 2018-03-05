Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELu7Iaxw5JUNtjp0j4+mhy7RqljPru3tlHr8XJjUXbrEz8KFVuuJ79qRkNxa7e+T/8YOzHVY
ARC-Seal: i=1; a=rsa-sha256; t=1520251897; cv=none;
        d=google.com; s=arc-20160816;
        b=B93bJSOPKMsamUnwmaR+l3VFW/coHFqy1mvUuSFPSe2Lp5qX8I7VSN2t730RhdEVn+
         QEtrR6VB6JV6lBAAdTX9vKyX+K5iGrf/Su7zIXRIRFdb0cOskp56vFxPglMDVI7OFvzb
         1lnsFtkYRgDk66DxTTgD5vQica/01s/HB5e28qFmdI/Y5fKC+KTTBqSYzp9JLmcq1EA9
         CFmpVqqi3+vvh6hW+ITk+MPtQ9vYwJwcsiiKDjA0OQQOwvWuUyiCiV1nrToXd1S2a6da
         t3SOZSMZfm03gj1JSpuo56oEWjju6TTaTOuGih2h/lPyt+44MZSp/soB9W7rlcXbmiLk
         WORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1ezV+SsEy2luLvcQHb/4B5Tmb5q9CUPmslmdU5NtZ6Q=;
        b=QagDLyQ1JPUkcknH72FjGr/cgFkrpUplNp4+4gIudcVYPEPt5HEp36dfi+7vhQ8vmz
         1plAvO6rPAJRylTeHSFoP+qYexVheiUd25j9Tg2FQrNAI5nU77EwGNuVsKPfZJTM3WQ0
         WrnfD+hKf+WhsAWnrtS1heax+USGrAnt0+OXZ6VItoLBJmZB6pGk0IU1SkkjfL0Qaf9w
         AwPb0pVL8GoSdD1gVoFfoopvjgCIodc2PiECfncpeneUM51BdnJ52aO4Vf7lVAICIJrK
         IuwMQULn3yQUjeS7uBylPnZeCPIAlTBm8nSO4RkMiT7BeGl5gDWKomtLQ2/TurgRyd5l
         eBDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TJo8Ir7C;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TJo8Ir7C;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Mon, 5 Mar 2018 04:11:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Randy Dunlap <rdunlap@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: add Co-Developed-by docs
Message-ID: <20180305121135.GA15079@bombadil.infradead.org>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
 <1520222301-11874-3-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520222301-11874-3-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068642266552204?=
X-GMAIL-MSGID: =?utf-8?q?1594099653511615096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 02:58:21PM +1100, Tobin C. Harding wrote:
> -12) When to use Acked-by: and Cc:
> ----------------------------------
> +12) When to use Acked-by: and Cc:, and Co-Developed-by:
> +-------------------------------------------------------

+12) When to use Acked-by:, Cc:, and Co-Developed-by:
