Return-Path: <agust@denx.de>
X-Google-Smtp-Source: AIpwx4/G3tJQIotTnmyaKvRi2YAsPy6nnhH1+OIlXt+yVzAZS5L9mgci3kSvEwnSyXk92EgL0QT2
ARC-Seal: i=1; a=rsa-sha256; t=1523867668; cv=none;
        d=google.com; s=arc-20160816;
        b=aEhe172BZpoogyyZEWzHiJ32pMlm+sXmgPKVXAEANV0NxgLcAoORVfA+5QBMR+LaUU
         q4x9zLkDLdqzoI3bKKPd8OXCHfCCI77L9NoejupTam5LnHHslk185HG/YDLDl30K5Y/m
         XivBZMLj10Y7s3iK7MZ1+DuPkmycrsjGkfN/d2EPJkt0JdMZTX6lrc87jmbxtpxJckvS
         GVt7MQYXaSH3TPLStxAk78F5H8Aqmc8VHXR6IFJZ7Kh3yXsyrTwJCJucobfFCmyZ4nHT
         GzytjP5e7kz0UBCv7xhxrVQ813k9M8KDoQDDwxkrTfvW2XgFUSUSqF6KIxqifnvyhRBB
         zZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Myyo2BbJYKJ8csYhIRQ+SCRZW7WB9rf6JweMwokCwiM=;
        b=J2vo6EKw/HXGjcaSoBu0U3Lcirv9DHvYO/bC4edIyje+o41oOuDJ1oITFDdejHM7ng
         QTAaan+EFiNTuYPxgX92YK/SBklQ9LupGG0XIpfjbtgVm193NyE357J6q6msE8xZEGpC
         zBMzZ8XuO8tBzjIb7xNebumILTjauXdm0eg1yGtt/fAzdV7roHg4zd/swwt+5RQBkSht
         q8ZQufc1o/XmoWBCCrHVqP7vOZS9y7Obgo/MPfGyxJ0OElwx0anIotyTFaa+4+bgWNS+
         ubJmpDIN7Stsinm2J6NSMtBtCrESF9fkFp3Mgnf0rhUd+gxHoxuaA0uzHVemZe34oWUu
         Smyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.18.0.9 is neither permitted nor denied by best guess record for domain of agust@denx.de) smtp.mailfrom=agust@denx.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.18.0.9 is neither permitted nor denied by best guess record for domain of agust@denx.de) smtp.mailfrom=agust@denx.de
X-Auth-Info: NmRLWXldwMp9q+bnlafMCfmeabz/v2sFETKwpKFL9FU=
Date: Mon, 16 Apr 2018 10:34:22 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, atull@kernel.org,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Message-ID: <20180416103422.5229b5fe@crub>
In-Reply-To: <20180416081008.GA31469@kroah.com>
References: <20180415183308.31402-1-mdf@kernel.org>
	<20180416081008.GA31469@kroah.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597838146681454116?=
X-GMAIL-MSGID: =?utf-8?q?1597891064519310138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 10:10:08 +0200
Greg KH gregkh@linuxfoundation.org wrote:
...
>> as discussed. Can you please take this bugfix for 4.17?
>> I rebased it against next.  
>
>Is it also needed in any older kernel versions?

It is needed in versions starting from v4.14.

thanks,

Anatolij
