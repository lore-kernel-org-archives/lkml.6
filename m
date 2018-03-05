Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520286328; cv=none;
        d=google.com; s=arc-20160816;
        b=jM8o6emE/d0FnoSoq156W4xhuHlFz2BHSUZFksDXhO1LhmejmGqBX3B9les6p+jGi6
         iKaUPY/vq9h/M6AWdXkYe7HCGojZgT6G9LOAZ3u1Gmw00OgfnGnV6C529cRxTUn1mn3B
         gZA1+cO6EaWIekDXpqUWmNN4/yasYM+ZvNelObflS7T4HhugxAJqWpgX1ZrwTgqb7QwQ
         W/EWgzWVIPcEb74fWr3uVJ15l8HVS33qw/x3QJwXy05HzFTjYahEX0EQc2JVwzvxuXTG
         aUvL+GKQUxKffSDqljuCowCAt22jnYkGWMbFEsqHnKz1/oGPjFqIFJTNZNW1J2E/plea
         3HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=yLwKuDaWXOZZERiZ8z8uthCTG1zGESJ33lvxbJ/QtDg=;
        b=wTW3e11BJ4ZJWryVgXZHIgKCoRWVvQt1+Zl+i+tGkoEPM+8rJMVFhffFY4PJzAws8m
         dtPteJNkDd8I0gBhMo26e0Zy9uxuzctFuLrNfq5Wqt4XVrKGUlY67HNaAxwVuJoelbw3
         QrrLfeeW/kJXU44+nAUoLwX/VLGYKpYQhVvMa9LsFatHv8X7lTqzj34t7MFRLQAyu11C
         c5wba4x8qqXv6ocTP1fW+sT25sFvjEJ1VxGN+250GoXLJpZl59p0ieNAIIWohnW/KmAN
         m9tAbzuCOK1/OSWuGSGRHPRfjxCYC3JATMBVFT4WCCC+6cKBpMQwalWGbamdLQnmOKIP
         4oLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JPXNHh2b;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JPXNHh2b;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu1HGTahvHOwe5RjMfi0PS/CydhwX/27WGsGxV9b3UpARBps4yko3Iuo95dl2ruJ3ESdmANPQ==
Date: Mon, 5 Mar 2018 21:45:21 +0000
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/2] pps: client: use new parport device model
Message-ID: <20180305214521.GA5844@sudip-tp>
References: <1517181729-5839-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517181729-5839-1-git-send-email-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590880356205541714?=
X-GMAIL-MSGID: =?utf-8?q?1594135757214663237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Jan 28, 2018 at 11:22:08PM +0000, Sudip Mukherjee wrote:
> Modify pps client driver to use the new parallel port device model.
> In that process, added an index to mention the device number when we
> have more than one parallel port.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> ---

Hi Greg,

A gentle reminder for this one.

--
Regards
Sudip
