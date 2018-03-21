Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELv9+L+J90UNqRPRGmI3Ny6xMirQZ8yFgHVLfUx8bLW7Qdm2l4AChwwH4plQaaAIVIPUEDgV
ARC-Seal: i=1; a=rsa-sha256; t=1521646264; cv=none;
        d=google.com; s=arc-20160816;
        b=gpAxvDT7/LVR9u/Q/6As6u20g+K8MepB/PiXDRUwqjJQWziRI+6mhaefVe8MBGV0e1
         ENuMbx+4wvVZPX9gldoPCbikHyxW2fqobn5N75A34d1V4xlmZ7kQAKa/dl4qkwfdQttc
         dvM3aMiJyJ/l9+6vEuPueicAprWrcPSK1HRwfe2ukzkDzdBhICtLanXSXr2h1pOOPiGm
         2qS0S9xcB6eV9unIS6+/NDPJ2WVLmn61EC7Zde8s3F/IU437y6Ddj4KXqi+TpsCzOsR6
         zG6VuGt/fQqRXPPweLyjQ/vrpfmE1pi0M7l/JfF/+hEfZzO40QXU4mCaKncqYp1xuh1e
         XR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=oQm10KAJXDFBzygdSL+E+4yhdmv1N2nAuMeMvCPFm2I=;
        b=YW4/M6lVwz2+TlGJd1QAi66RHJHbdDoxgTA3h2QxQ5VnObzLg9VJYVV4qLON98tI8/
         dM1Dq4Olp2/t/y4Fi2cH1dEW/sxYJzxev7feOrwwkkGTGABsTnYPysV50MVAiVocNgnv
         O9ZQqNFkL+AJysz9rMlRHD9nrIe82ZNPwoX7kkJHNw5DuEDkPW//tZ6vbGX7/2QDEwSu
         rCAw48dtNOFvTIjtPA5YT+5MpmERDbqlwSYMWnnxPe+8wUU2pE9R5+svBTxbkA2Q2Y/V
         HzRitK9kuEthjMi9G5F208kWVCGoHs/ykkL5M+xm5WkTkbM1uDglE6T5eLHTAazZcNCP
         iaGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:31:02 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia
 Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] HID: ntrig: document sysfs interface
Message-ID: <20180321093102.50e7b6f4@lwn.net>
In-Reply-To: <20180321092805.279a8dde@lwn.net>
References: <20180302053017.GA23123@mordor.localdomain>
	<20180321092805.279a8dde@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593802620168296630?=
X-GMAIL-MSGID: =?utf-8?q?1595561753469128989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 09:28:05 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> > Add sysfs documentation for N-Trig touchscreens under Documentation/ABI.
> > Descriptions have been collected from code comments.  
> 
> Applied to the docs tree, thanks.

Oops, I thought I'd checked to see whether Jiri had picked these up, but I
evidently haven't had enough coffee yet.  Since they're taken care of,
I'll unapply them; sorry for the noise.

jon
