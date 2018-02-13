Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518532889; cv=none;
        d=google.com; s=arc-20160816;
        b=cs9OFRMAhxNoD2q8KZOezOG1+2t64Ar1MXFA0Q2zDhDUr27Ydh1NTNCBBcItgt8fzf
         skrk6PmHjtAXesFiGtmDeaMU7XU1BncttvvJE3VM3GtkwRuwReJIGi7Xr/RenJ30/Yi8
         bqzIVpiFC7JBGFGhUfGhaojH39FW3WgqDUj3hnjQ8iTpkPvTilwL179N2nFQSoAwOybo
         RaLDWbS5W81YfPo1nKAOK01nL9eHKb34mG2kU3Oskfj7QCPy2jadSQ6/62UBzYYvIWng
         8cTeWqo/KzesSBrHkaimLXcRdH0VnY3vN22c9eSgZthf1QvR/Dc4tpqaujE9zHNkaWRc
         YFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=rVKe2Fp0b52h3ah+jqeLiTs8xw87eykbtJY34BjvPCg=;
        b=NGIVy6w62bC+aFwKRsdzglvVytaa626ouMLMZvICiVEaNazqDgs89/VWEqjyj+cvHg
         bb5HcwsQeuIukOwrhpTmtIiiz0cejD67zeoZi25OSTPU71d0BXa6inq6LJEwRsh8oBTj
         6HYFo+rjkpkO4AAKdoyfaIGJ/Die/W3RiweGY5DwxAo2l8dshLvq3f/GiVKcm84xeera
         pzywHUSttuorE0AuIfY7DIBPsNiWmYKZyQjkVdoowe1Mvc910fQzN895clL2liWocvwf
         OQgObm53fAwmMcpXUM8HBj7RBNxYhvfk1jibhn4NOUV9Wjyf1UM42ufmFADhniDs5Boc
         w8SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GSRzlneg;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GSRzlneg;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AH8x224r1B9N0QTySG7QcNtC/Et3Szf8MSY0kVz6FW4xWlAak5qIWSgr8BnTQdYx0R2eiqulZIl7wQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Feb 2018 06:41:26 -0800
From: Tejun Heo <tj@kernel.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] libata: update documentation for sysfs interfaces
Message-ID: <20180213144126.GN695913@devbig577.frc2.facebook.com>
References: <20180213081816.GA11350@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213081816.GA11350@mordor.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592273039999135902?=
X-GMAIL-MSGID: =?utf-8?q?1592297143656204414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 01:48:16PM +0530, Aishwarya Pant wrote:
> Dcoumentation has been added by parsing through git commit history and
> reading code. This might be useful for scripting and tracking changes in
> the ABI.
> 
> I do not have complete descriptions for the following 3 attributes; they
> have been annotated with the comment [to be documented] -
> 
> 	/sys/class/scsi_host/hostX/ahci_port_cmd
> 	/sys/class/scsi_host/hostX/ahci_host_caps
> 	/sys/class/scsi_host/hostX/ahci_host_cap2
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
