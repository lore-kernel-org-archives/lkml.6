Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBC4PQDKQKGQEJN3JN7I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520437132; cv=pass;
        d=google.com; s=arc-20160816;
        b=CV9Y+HYs/SJjKLIOutXCiv7u4iUdy/gfyqO1D7j9bcM4V3nDFDPlB2CnG7nuYSLs1i
         35c58q5rJy2SYySEuVr09C5bujzdhAqVi/tbBOu5qGxu5uIGIuKERXWtHiON42fzq4QK
         C7Bx2riwAZQfhbDlcgT4FV5YfZxTo22Qr/xUnxkBupdYH6AbQ3WsiI3uupm7CilYnaoX
         ZGxfxR9J35PxcLzGUkke4WjSEolVF1S7ukNmlKAiAo40P8o4GImsptkWIC28eE3cPidL
         CYZpXzusKc3yWMu9GMUTpntKFvlGomQ+/UeYlO0pLGX/wWRojp15hmFv/jx+MfyLdftH
         cnwQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=tTW6B2tRQgI9njJ8JTAts31S/7ec5t5VCjIm6Yawchc=;
        b=e9vEGW0OlH9vZ2uepk9Q9sFJ4lZ1wNQYZ0X2ihyozAErMp+xDoVg0z7KUpfz2T6glm
         2zwrdJLx2g6mjYfKKFRS7/OFygE6y7BEIc6xSk2WO+XnGaJFSWpKBQrkjusWuGHIpiLv
         /wVuOrfhcb6jb9x4MHXaTNVoKPsRNZ0ZxY0MVXj0WrauNhNHBT53/yKJya5ThX38gizI
         zJyQP1H2QqGjyjS/ydyreRvjtjItkbiBkZyWLin+jXFH+HFMdarGoS8VZIhVKAewv9n+
         D3T0D4BHtcZOD/TvU5CMYLYNQonm90dMJ1xqVMhO2lDjrELwn1yq1PPhItjyho90pnD8
         JXQg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=frYfxX4/;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YuFfB/9/;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbc4pqdkqkgqejn3jn7i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBC4PQDKQKGQEJN3JN7I@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=frYfxX4/;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YuFfB/9/;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbc4pqdkqkgqejn3jn7i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBC4PQDKQKGQEJN3JN7I@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520437132; cv=pass;
        d=google.com; s=arc-20160816;
        b=POtiAKAFH78e/Lf25lNVwhhtf5UBaTt0l3EMo+mWXT2jFilLa0RFhGdL7nvZXJM1RP
         CS4AepAfuvtqm3igv2CqUQ6UgZqEa6ZWENJILiA8TcwF/3eeLiBTG0PrbiBrz/g+UfAa
         0K7Y1b0LlSKgwQTeWhQEF0jD85qWrnfkYwG1lWVBTbVkWvt4F8AdrIv0dIiLpvhnS1/k
         oWgTXPdrlzkW6HZnIP+2M6VJ+YPEMscFveHc3+id9mrzzQcHACskddI4xHv8NKmDgL7Q
         J7hiTvu78+Zgzv3I+tKJaGZq6VB8wGcWDbnVfjX7MvWoLxybu8mu140rDIA6DPFKBzdw
         ptXg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=tTW6B2tRQgI9njJ8JTAts31S/7ec5t5VCjIm6Yawchc=;
        b=rdSQnL+KVtc3ICuYMiK6d5R5YeGxHQQD9KZ87XdK6BdjJKtiZGYMBObvH9/HIHojzd
         Q3yF0ORveFCmfWykX8a5SNw2JJKeej9w0SsMJmuAftLCWI27ytNDS3L9BlLGJxsuINAc
         8OvAhGgK5Giv2mzAqF5/uNGWR1aNPFzwNYtY9xFXIuhnBVr4E7+TUtFiNqJ4YJyQ+U1b
         4svrQSSiWQYrQ3zV2ZRhSGRU7g9mdQ7kekYgjtmEQJVBDHw2/QH6RKucorpb3DXsg/gQ
         kayEfZhM9GMiN8Qj2ulHpNADqCaCGRKSXC12bteevQgPZMW+bnjH7KU4UxeXl59tWZ3D
         f1vA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ddx6OV+O;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22d as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELvZtQIy+fsVgBLhRajhY0aok62XL/YW2LlxOIsn+z98zV+2ynZF1m4/56CdonazY+E6fhf1ZA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520437131; cv=none;
        d=google.com; s=arc-20160816;
        b=EQdjBcIaSnHDE+wWb7AakzppqxYQoLWjFnWeOugb8N2S29G65nhzM/C9IBSTpuk12d
         MwYsQ80o/P0kJ15GBXmhx1T5l4l+GeYrhNCdbFTxi+5yLoI16oPmyrGJop3Rl+QYPlhU
         /6f43M+Jr0nlJ/PaXaxyB2g1tnDF68dxBXndOLJd642qbY5nPxlj+/pQEIQmumiEPlKk
         nfkMVdFqs+S7VCbWZsWAzRaBVjSoAeMsjqZdiFnCHN451UTb3CRMQMq0UUGUK6urVl7u
         wc14ZZ3qcrBiltdz1KYHKwv1+nuWkRqda0S9jUJfKTKb2+ZP+4KAE3UtYym3xl+phonn
         tAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YlE9b00li9H4gRQDdawn/FdTga1NoFStxFYJqvpAQBs=;
        b=fVI9P45jSRVyxdOQey/QtfDA/Q/L/JbUzDB/kenJAAnNJrlECU9DfFh+kQlWbgCmXE
         GfYSDrUHMDfducrumE5YlBkz7YP+S7QMxeLmvRBbn6RomhcCLbvPSekPHoyT9CaPVhdL
         job0N9D/WE5gfHkFH1fUjNArNgygl+xUUyRRQeHH5Tl8JJucI7jYEMD/JJX1FwNtrEOg
         qh6RLqzCQMdEqPLx//UHljix/EZAZ4TlAWK8RD4I8PRZEZuA1hJUSbVI0ttsDAzG7nwV
         1+mcsY4u+yMUrvbKscYZS6DdtfpVfx1QeNdoEuq/aHwYjHTCfsTPeZUSRRqQOiUaVZ5o
         i3oA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ddx6OV+O;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22d as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <2872216.aoWXzO2rYL@blindfold>
References: <20180303140233.GA9634@seema-Inspiron-15-3567> <2872216.aoWXzO2rYL@blindfold>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Wed, 7 Mar 2018 21:08:50 +0530
Message-ID: <CA+XqjF-2K48uEPHhgoH4K+4X0Gnr=S3VaG4-VeZ9urfsNEf3QQ@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH] mtd: nand: Added spaces around ('='
 and '<')
To: Richard Weinberger <richard@nod.at>
Cc: boris.brezillon@free-electrons.com, David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary="f4f5e80755241497b00566d45bdc"
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=Ddx6OV+O;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2a00:1450:4010:c07::22d as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593925468888777014?=
X-GMAIL-MSGID: =?utf-8?q?1594293886595168603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f4f5e80755241497b00566d45bdc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 5, 2018 at 9:12 PM, Richard Weinberger <richard@nod.at> wrote:

> Arushi Singhal,
>
> Am Samstag, 3. M=C3=A4rz 2018, 15:02:33 CET schrieb Arushi Singhal:
> > Add spaces around ('=3D' and '<'),  to conform to the Linux
> > kernel coding style. Issue found using checkpatch.
>
> please fix real issues. Coding style fixes to existing code just add too
> much
> churn. Except for drivers/staging/.
>

Hello Richard
Thanks for explaining,


>
> If you're looking for a small MTD related project, I can offer the
> following.
> Cleanup all ubi_assert()s in drivers/mtd/ubi/.
> Some of them need to be transformed into a meaningful warning/error
> message,
> others into a hard error, such as WARN_ON().
> Review/understand every ubi_assert() and convert it.
>

Before doing this task, I read about this discussion (
http://lists.infradead.org/pipermail/linux-mtd/2014-November/056352.html ).
In this discussion it is decided to split ubi_assert() into two different
functions, BUG_ON() and WARN_ON(). Even some of the asserts can be removed
too.

Hope, I am not missing anything.

Thanks
Arushi


>
> Thanks,
> //richard
>

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/CA%2BXqjF-2K48uEPHhgoH4K%2B4X0Gnr%3DS3VaG4-VeZ9urfsNEf3QQ%=
40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.

--f4f5e80755241497b00566d45bdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 5, 2018 at 9:12 PM, Richard Weinberger <span dir=3D"ltr">&l=
t;<a href=3D"mailto:richard@nod.at" target=3D"_blank">richard@nod.at</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Arushi=
 Singhal,<br>
<span class=3D"gmail-"><br>
Am Samstag, 3. M=C3=A4rz 2018, 15:02:33 CET schrieb Arushi Singhal:<br>
&gt; Add spaces around (&#39;=3D&#39; and &#39;&lt;&#39;),=C2=A0 to conform=
 to the Linux<br>
&gt; kernel coding style. Issue found using checkpatch.<br>
<br>
</span>please fix real issues. Coding style fixes to existing code just add=
 too much<br>
churn. Except for drivers/staging/.<br></blockquote><div><br>Hello Richard<=
br></div><div>Thanks for explaining,<br>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
If you&#39;re looking for a small MTD related project, I can offer the foll=
owing.<br>
Cleanup all ubi_assert()s in drivers/mtd/ubi/.<br>
Some of them need to be transformed into a meaningful warning/error message=
,<br>
others into a hard error, such as WARN_ON().<br>
Review/understand every ubi_assert() and convert it.<br></blockquote><div><=
br></div><div>Before doing this task, I read about this discussion ( <a hre=
f=3D"http://lists.infradead.org/pipermail/linux-mtd/2014-November/056352.ht=
ml">http://lists.infradead.org/pipermail/linux-mtd/2014-November/056352.htm=
l</a> ).<br></div><div>In this discussion it is decided to split ubi_assert=
() into two different functions, BUG_ON() and WARN_ON(). Even some of the a=
sserts can be removed too.<br></div><div><br></div><div>Hope, I am not miss=
ing anything.<br><br></div><div>Thanks<br></div><div>Arushi<br></div><div>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;outreachy-kernel&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:outreachy-kernel+unsubscribe@googlegroups.com">ou=
treachy-kernel+unsubscribe@googlegroups.com</a>.<br />
To post to this group, send email to <a href=3D"mailto:outreachy-kernel@goo=
glegroups.com">outreachy-kernel@googlegroups.com</a>.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/outreachy-kernel/CA%2BXqjF-2K48uEPHhgoH4K%2B4X0Gnr%3DS3VaG4-VeZ9=
urfsNEf3QQ%40mail.gmail.com?utm_medium=3Demail&utm_source=3Dfooter">https:/=
/groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF-2K48uEPHhgoH4K%2B4X0G=
nr%3DS3VaG4-VeZ9urfsNEf3QQ%40mail.gmail.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f4f5e80755241497b00566d45bdc--
