Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AB8JxZpDCUm97t0Dt79OlDbzvxq5xhA6Grp1wdnWRbFxTffCSAQ95Xffda3sWtZyNq3DLHz6Wcs7
ARC-Seal: i=1; a=rsa-sha256; t=1525796026; cv=none;
        d=google.com; s=arc-20160816;
        b=Ppwy5ExrQ2j0F9GQ/iwkbrMhIMljRiTvJ1zGuss9I49+kMK+kXNJp52DcpjtrprCDR
         kzkLaGT0OgLh4uPVe8dwUR9qtAg++fzTPzrSrSmzRFEOUn6G2nbSJ8m7YJXDFz47oRiZ
         56Bm3o50XqahG/ckXMnpfm08jLpeoGggtpCYGQsiiuipnq1pebTA/L4BLmXD8B1AwA4u
         GFCNqaTGkRgQl5vi8Pmnw+AMW41NOyioTWq5kRnhn5E5T46vs4CNk8ObfTauVWiwfOhA
         H361mnoQ7iSqVbzL6IymcgPXY3RavbPYVG1J4dX3DkLgZpdmRyo0w4eDdeYs7YYSiqY6
         LAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=j9lPtzfg3ogWLxoO1uxi33CO0Zy0dX31YZnAIrWMFDw=;
        b=XQzwLiAfT8jQfDcVdDfeO7nqf1pDD0/6mX9mc69JcC1xfu2W2SgsBTi1XwiTFgyD0e
         7QDdfacNtY7JjXeEZVWAGM2ciEmMPA5S3SIUylrAK/mBy0vyOIKxVue2nIcSLSmD5Ipe
         FoiBybEnZ+DD0OKsx9ba2Pj5wlZtavH9cVwNcAgP5mffNWemTkD00ARnf1fABP9DSopT
         wfcd7ScX+a4TR6hPSQvP+JuaF9P1znvFPrUldemqryInS7Q5A4yAUw3/TK2YmVs6d0WK
         D1NWzNgBqoYeEo3txZ9BN/w+ecpUQd2CzhPFjIkNYl0Gg8XFukqrwfws1Vb15Bsly36y
         zbdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Tue, 8 May 2018 10:13:42 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho
 Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fbdev@vger.kernel.org, linux-can@vger.kernel.org, "Luis R. Rodriguez"
 <mcgrof@kernel.org>, linux-iio@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-crypto@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/18] Fix some build warnings/errors with Sphinx
Message-ID: <20180508101342.2bde20ea@lwn.net>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797475301602798?=
X-GMAIL-MSGID: =?utf-8?q?1599913094454147052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  7 May 2018 06:35:36 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> I decided to give a try with Sphinx last stable version
> (1.17.4), and noticed several issues. The worse one was
> with the networking book: a non-standard footnote there
> with [*] instead of a number causes it to break PDF building.
> 
> So, I took some spare time to address some warnings all over
> the tree, and moved a few text documents to a book. 

OK, I've applied the ones that seem to make sense for me to take now.
There's comments on the firmware one, and I'd rather have Tejun's OK for
the cgroup one.  The code-comment changes should probably go via the
usual maintainers.

> I with
> I had more time to move the other ones and to solve other
> warnings.

You and me both - but each step helps!

Thanks,

jon
