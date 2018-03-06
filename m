Return-Path: <jikos@kernel.org>
X-Google-Smtp-Source: AG47ELv4gEpfo0l6AcpXqhm9rM35vSLOZvfjx3jtStPJbO9c7teee1mIY54LNatjDyx4XKiv6Wca
ARC-Seal: i=1; a=rsa-sha256; t=1520345914; cv=none;
        d=google.com; s=arc-20160816;
        b=McD1kXJu6BR2ZVUs/hMhXSTmtBxusRvPTcBFtf8fQhM7dEXqTlWVsOUmCiudqLYBrL
         AD7A3KS0laLwos+2jsDoF+VCYTEZaPpv1eebqSDJdFiZgA0r2v1qeOIUyWGxzKR5YDZU
         EuLr/IeWD/JFg4BEKhIKCiq3CTfZO5CeijvPIHwsZ8WGlJzsiaDwy5vfU6ThmnnO5tzY
         TS959EhhQyWdwEqR5+FNkkuX/ETt7gvul4JPNKWq0i8PrqOBfQIE8S6ky76NYirxO52f
         FvRsvqyTJ9od3RCWZxKXyFSk/hFjmOL5yg/XDW+A9rHmPbqCTjacWrbDzyV+4RwEsK4a
         dqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=uMEq+f6c24URjSGl606uSNAVniAmr4IzAEJXn6QFqAA=;
        b=XXh0QgUDaj4oSGFFvJN5xfqW7oqlEoGXVbVc9Yb2sFuvolUqjjLt8fUNjTTFyckaHX
         5bTbatfpQOTRVr7j3FjckbPCJWqPBoBxXrex7U/0wmCBZlvKZf9vqJ9AECUetv2Gf+E5
         mG50E305Taky0XxAu2Vweg/v7GRwJSO1GbJrrvTeUYrGwxLRHLmeROjZ4WsOvjsnLibI
         mOfJlMYclLX+CmiT29uptVt/WHO/pbjhCuFOjLn/ropmZyBer2KFfAeXod5riQGV/XDX
         /9dgOSvsykaUYuaTGE2KKS27/XHzwdOObUOkLB0DBSRnkzalkgj+yt3FxRTxW1aiRSmi
         6sVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Date: Tue, 6 Mar 2018 15:18:32 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aishwarya Pant <aishpant@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
    Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
    Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: document sysfs interface
In-Reply-To: <20180302131653.GA24934@mordor.localdomain>
Message-ID: <nycvar.YFH.7.76.1803061518140.15778@cbobk.fhfr.pm>
References: <20180302131653.GA24934@mordor.localdomain>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593831975590179411?=
X-GMAIL-MSGID: =?utf-8?q?1594198237732531848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018, Aishwarya Pant wrote:

> Descriptions have been collected from git commit logs.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
