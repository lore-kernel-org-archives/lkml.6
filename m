Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx49LUacMq0sJ9wymRgXcVfi3pubgu3A9aGswyon9s5vhq49Bv0u3JeiSMdYdeK/MF1eAiww+
ARC-Seal: i=1; a=rsa-sha256; t=1522249945; cv=none;
        d=google.com; s=arc-20160816;
        b=pT4I1jsfigeJj7yLIlkVM19OcgqO8IcCmNnXknFWWfeqwvP/r6n25UWJ29SO7AosO/
         YoF5yOJePb5FMDfvQkDAt5AfuPrxoS5tFqCcIMJVIo02JUeu7++r4+Dl4bDpdiBU1A9r
         xboCzVzMf8wHkbyjUKOrabti7iQ4tU90e24oF2pyY19Q4FEMzYAZNzfyucZGoVdwPmS9
         O6oFwz1dMrlyatwaxZ4QXqyKC4oh8bGKiuNkIqyNzN+Fs3Czp8dUIJn7eKsdgiYsTHMm
         u8iWtySodB1OxWSKRTu8SgmAH2NL2lol7f2d8dBqfG3ib1fc5qWyrKVOJqJcIe5aC+7L
         AMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=YA89KBxaT/doEONaGViAEXpXyVaacq+nGPBJ36iKxcM=;
        b=EGAXpopmMTg8iuNG75zTTW+QMzjoCX3BOzMah+U4EkpHOqgE03pIn8XXD0dpkwWcbW
         pj8FSO8SSk/umhrtbfZeGfAPnDqN6JWsxLYRys+BgD5V3qmcU+lS9QHOPdNycFN6V9tX
         Uug4/cse2i43OgzZtytht0wEvpiaAZs2rKJ3I3kn1LfeET51hEnrXuV8xMn05/DJ3U/k
         rEv3izC1Nyep7/j3ycvVAuWiDuBux+oUALBCpgMb30uiBM3q1FC2Uq/Twx3+JO64CkSg
         PPC5oS3Sbm/tbXDJcJjkhjqc5eaVALmANbEHGsnYt5xNrnSxtbcLhPXC8cqfvk/YYcA6
         lyiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MV3klA7I;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MbboNGjk;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MV3klA7I;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MbboNGjk;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Mar 2018 20:42:24 +0530
From: poza@codeaurora.org
To: "Bjorn Helgaas <bhelgaas@google.com> Keith Busch"
 <keith.busch@intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
 Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
In-Reply-To: <20180314205614.GA30695@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
 <20180314205230.GF29867@localhost.localdomain>
 <20180314205614.GA30695@localhost.localdomain>
Message-ID: <2c8f07a740aa82aba575574dad3d4566@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928862601446730?=
X-GMAIL-MSGID: =?utf-8?q?1596194758685616180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-15 02:26, Keith Busch wrote:
> On Wed, Mar 14, 2018 at 02:52:30PM -0600, Keith Busch wrote:
>> 
>> Reviewed-by: Keith Busch <keith
> 
> Whoops, I accidentally truncated my message. My correct tag:
> 
> Reviewed-by: Keith Busch <keith.busch@intel.com>

Hi Bjorn,

Can this be merged ?

Regards,
Oza.
