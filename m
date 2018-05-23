Return-Path: <SRS0=+d69=IK=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZpdSQD6jiNOadDd1WVC8L1sNUro6QGIJ8SpS0T5AsoOJQRmGV9f2IyhFsQ6owXFOY7miwYT
ARC-Seal: i=1; a=rsa-sha256; t=1527086800; cv=none;
        d=google.com; s=arc-20160816;
        b=egBWQC5OzxC0L0E7CRxTrLgn/TOk2AcU/UsutTzyZYP9oOfeGR/S0nylNZps9gDXi8
         uq1Y2BB3ZGTl+2lX4QUYlQLTQ0ufQni/8NCBemrqMpD5CHKvnblZpaLZ7Kae8p40DWJF
         1ZQSJzmPjqIMurHgum/sBZhnegmsFJHWP4DgQqG5i3cI0f48tV0134dsqieiHgeOaXh3
         HVgIf4lDX5Vvm5044oKyVhgwNgoSfnfYEi6xzmX44nQxGP5zEgqrIdBsru64WfeJMRDd
         GoTCTSxqPU2yto53l4O5WNlvG6OEW/lNXySmD8icMAjEIbkgNwlyUzRhvXde1gQKPTbC
         c87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5THo9B8AgiL5hk6DJrlKFaL/t5fWvkKSqSXWORV5Uwg=;
        b=Y/HAWwpau2dvPbkVC1M8p1S2Wa56d/zhO7hN7WEhDTEKWZnthYy2PU+9f2fmQSKIZs
         LxMd6nzzw/gexu2DiYzn9jY4H4gX25nADlC7I3+wX1epNgKOjdyc9hRho4qq2pRvhQrd
         8oC+pLVGc9ZJ8IVM1o24/ju7NEm5gN8PglQqdCDjlXxv2ZoDUhbdOBJc4fExpD6mlJPY
         ZuUrFhmVQXmTRsY52mhol91jRQTi1xLpRJIVr2ca6NY43PWY/I4jjyalFEwDxT83BcSL
         W8gxTKH61RhDwbOyGnNwshc6pxyrnMiydRJfvENSfb2k7NqM/L9hN27awcWCLEMPSLLD
         2a+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Date: Wed, 23 May 2018 10:46:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Jes Sorensen <jsorensen@fb.com>, Matthew Wilcox <willy@infradead.org>,
 Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Frederick Lawler <fred@fredlawl.com>, Oza
 Pawandeep <poza@codeaurora.org>, Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Tai
 <thomas.tai@oracle.com>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle McMartin
 <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure
 for AER capable devices
Message-ID: <20180523104636.55303f16@gandalf.local.home>
In-Reply-To: <ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
	<20180522222805.80314-2-rajatja@google.com>
	<62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
	<20180523142656.GE19987@bombadil.infradead.org>
	<46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
	<ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601266569281581775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018 09:33:30 -0500
"Alex G." <mr.nuke.me@gmail.com> wrote:

> > Well I'll agree to disagree with Linus on this one. It's ugly as fsck
> > and allows for ambiguous statements in the code.  
> 
> You misspelled "fuck".

No, Jes is Danish. That's how they spell it.

-- Steve
