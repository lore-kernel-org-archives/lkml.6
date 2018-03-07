Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRB2UAQHKQKGQEP6PWDRI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520451690; cv=pass;
        d=google.com; s=arc-20160816;
        b=YlDKx9svJkLp+BGfjFckYLTMLRY5F95BynPCN/sQ9vJdYEy+FiMo95D2wJ+lp9L6FB
         LVXhSPxdQjCinyiPODajt9Nq2sRTMoSiQSRcAglKmhjnXICNKUFo9NL6XKWQEi+xxx7D
         B5WfuRy8e4+id1IcyoQ+As6fl+1ir7yQNcNxwt0eg8utPJXhDvlXMQxsnSzEDm49tpjS
         8EPcr7eFbQE2F3/xholUayZn3rh0QjeSA2GX6W69q9ZjvUec0H7d+GdykJRJBus6XE74
         MSUTbhWH2+g9FfY77S8/IUy2I5lyT1jVsLmw9jrFNVnV+82MNH5fHblkBeRkvKaFDpEj
         tjqg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=3mMhGjQzuIHYbFoUj06/EMgHD64a379PfmSK7uJafbM=;
        b=qiJtnijVNfrQZDldpwsmg6gdeYireFnpVjftl5Rl+pOcsQ+IR2PaQ8DoEDU1pucTgu
         +GY5QxO8BiIxfSKTRPFJLaQgVEEvOpFGfjtBv9D59EqqGUDQej68OcEAqvOSlA4kJkxb
         M8s0kHDKKfrNI4ac0u35S0BrUF5UNzAtnU0tRxEiyxPO8BUd7Qi1hLs5Odb5fVSzLSRI
         NSQUW89lW12Zel+R6gAmbnSMMRW2wDUzLBpDmTXVGUPcfuT9Mf7/Z1KIm8xpKN80xFIM
         KUkKCSb77MLY+qa/6Blcz0xWmbRqbg74drxC54nDFNGJxsRgCan3Ht/YcNyZoWv5Cp61
         Ch3Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rIShzVN+;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb2uaqhkqkgqep6pwdri@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB2UAQHKQKGQEP6PWDRI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rIShzVN+;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb2uaqhkqkgqep6pwdri@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB2UAQHKQKGQEP6PWDRI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520451690; cv=pass;
        d=google.com; s=arc-20160816;
        b=cyy6Ts4Ayin0l9ehs+pG4CPrRhCDJaXJh3BhQZCVJfMoMfe07y32V4zZvw8Y//Rv/h
         PA/gp6Kkrf9M+fgVKqGHt8gh4e+DlVviWZHgnuTn/ZP+y65V9l2veQT02GHA6SCxTwRz
         bONUOiE4yAL7yC+xDcmEZh1kCWgTVQvoLo2N1gSkvQo/XYj+sYjllQ1CAfQD3V3dYPSO
         YouBekduzocoLUzvHSGI+Taize8PF5Yj0Oql2bUb5h+kFNwFVyoCzECD8qZWoqbHng2P
         o8Vio5yvyinFobzHqTzleoeiypJtbWWX+GiKneq0oqRHQRFSH6h1j+4W2L8WX8GH/6cu
         7GwA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=3mMhGjQzuIHYbFoUj06/EMgHD64a379PfmSK7uJafbM=;
        b=wjXGX5l4B7KgIbCqzCpMas7Vsv4RqohjQLXs4IqQtm33h5ijaNV7SlH0/Gon/uuM+I
         1r356TKEmTg1coxAJaq5hpnXo0dIPgmXwW18jSyFxIlUe89ptSAhr0VzTlZ4E20P0VcO
         /JPpKOUwa8iQEPedQqbV5X5r68tPhUGR4coPZhybuDvRYAEmwryaynzu5JwteqCNRRCA
         uYb6j8TKD+pm7gUpxGJENAao5ZZIt6gz1IH5ieKF4Uzt9M4EX3iH6Vn2p75cq9nK9Dn7
         KFH0Br+blgbvIF4sukmx/EY2Ke3+K7zINuiXYHAKod6DNXzD5O7fNEYjGiKxkrnTD/dU
         eOZg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELt4mbxEBH7aBBKft7xuydd0O5k8CxYFV2muwIyykvRYucW60GynKYvjJX9q3Wvrq19urnscYA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520451689; cv=none;
        d=google.com; s=arc-20160816;
        b=eaeTLgcL0Luh1QNhmXmNSyEMbY3XOZMZWpfZBNNgCIiQjoq7gofCJv1ilp7oZCkUoF
         lVbNlimQtAQMckqWiLJ8L9eiwIrqn5nNNRuUivs6BoqlN0a9aGnqeLpHyrfnbsRooHoj
         18kOBEnZ2zoL2FY18h7BB+tFmBIStiU00XmGlDHoI6PnZYb/ni5fTA7XlL8b81+pY70B
         CWkEUQlNwYIjejj83AqtYA77PGaVWDkSYgllwU4hU9noP2HM/4z+hW6ZzYjpJcIaJ2T5
         u4Zt/iWPHCN0oOcsxjDMXGCCVExMClpF6ur6tue/drbh1ukO1nx+Wxk9/eCV10Xzyktw
         yJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=x3DFct0gzDLqj5ZWkpGS/2/Lto0euLgOpunajAICXN4=;
        b=jMNFw35nXZgPqerZ/I052dWq6WE1xxu4+DiGy/GqBHDVxC6Z4bDzCh/VIZg6UPLqRd
         LCVmgSSpnVqae09NfkJecnMX4wfXutsQ+Oehdh2IGdDbR432nU+jh4hkhRqAVKRjpyB0
         /o/ZJ9lsIST0n++iFIL3VBaktpEyvWM86ftHaYSXiCqI+dlwi10AsooPyng5NP1zNq6S
         CSl9PGoCGspW6zmzjQJ7vCPy136v1GSPOxvEvVQ7OWmvnr2e5HKnW1C020M+VwMubSUj
         8aSgbioZ1Zd8bXdDQhtvZ2It9L+2QwsXB+F2uU7d8V5p9LJZg5iG+eaBW+wqcRCtcF4B
         IEog==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,437,1515452400";
   d="scan'208";a="316918024"
Date: Wed, 7 Mar 2018 20:41:29 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: David Miller <davem@davemloft.net>, jdmason@kudzu.us,
    Jakub Kicinski <jakub.kicinski@netronome.com>,
    Linux Kernel Network Developers <netdev@vger.kernel.org>,
    LKML <linux-kernel@vger.kernel.org>, oss-drivers@netronome.com,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
In-Reply-To: <CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803072039260.2814@hadrien>
References: <20180303161456.GA20194@seema-Inspiron-15-3567> <20180307.103901.1771176275743006915.davem@davemloft.net> <CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1036440338-1520451689=:2814"
X-Original-Sender: julia.lawall@lip6.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 192.134.164.83 is neither permitted nor denied by domain of
 julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1594309151890309527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1036440338-1520451689=:2814
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 7 Mar 2018, Arushi Singhal wrote:

>
>
> On Wed, Mar 7, 2018 at 9:09 PM, David Miller <davem@davemloft.net> wrote:
>       From: Arushi Singhal <arushisinghal19971997@gmail.com>
>       Date: Sat, 3 Mar 2018 21:44:56 +0530
>
>       > Continue at the bottom of a loop are removed.
>       > Issue found using drop_continue.cocci Coccinelle script.
>       >
>       > Signed-off-by: Arushi Singhal
>       <arushisinghal19971997@gmail.com>
>       > ---
>       > Changes in v2:
>       > - Braces is dropped from if with single statement.
>
>       Sorry there is no way I am applying this.
>
>       Just blindly removing continue statements that some static
>       checker
>       or compiler warning mentions is completely unacceptable.
>
>       Actually _LOOK_ at this code:
>
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(cards[i]=
.vendor_id) {
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for(j=3D0;j<3;j++)
>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
>       =C2=A0if(inb(ioaddr+cards[i].addr_offset+j) !=3D cards[i].vendor_id=
[j])
>       {
>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
>       =C2=A0if(inb(ioaddr+cards[i].addr_offset+j) !=3D cards[i].vendor_id=
[j])
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
lease_region(ioaddr,
>       cards[i].total_size);
>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0contin=
ue;
>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>       The extraneous continue statement is the _least_ of the problems
>       here.
>
>
> Hello David
>
> Yes you are correct.
> =C2=A0
>
>       This code, if the if() statement triggers, will release the
>       ioaddr
>       region and then _CONTINUE_ the for(j) loop, and try to access
>       the
>       registers using the same 'ioaddr' again.
>
>       That's actually a _REAL_ bug, and you're making it seem like
>       the behavior is intentional by editing it like this.
>
>       And the bug probably exists because this entire sequence has
>       misaligned closing curly braces.=C2=A0 It makes it look like
>       the continue is for the outer loop, which would be fine.
>
>       But it's not.=C2=A0 It's for the inner loop, and this causes the "u=
se
>       ioaddr after releasing it" bug.
>
>
> Yes I know it's for the inner loop.
> But I am not able to find, where I am wrong here

Arushi,

You are preserving the current behavior and David is telling you that the
current behavior is incorrect.  He doesn't want a patch that changes the
code but preesrves the current (wrong) behavior, because that somehow
contributes to the illusion that the incorrect code is correct.

julia

>
> For example
> BEFORE:-
> for(i=3D1;i<10;i++)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (expr1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
statement;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
continue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> After My Patch
> for(i=3D1;i<10;i++)
> =C2=A0=C2=A0=C2=A0 if (expr1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 statement;
>
> I am not understanding where I am getting wrong in understanding this.
> For me both are equivalent.
>
> I Agree with Jakub reply:-
> "This is an error handling path so the continue makes sense here to
> indicate the processing can't ever fall through if more statements are
> ever added to the loop.=C2=A0 But OK."
>
> Thanks
> Arushi
>
>
>       Please do not submit patches like this one, it makes for a lot
>       of
>       wasted auditing and review for people.=C2=A0 The onus is on you to
>       read
>       and understand the code you are editing before submitting your
>       changes.
>
>       Thank you.
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visithttps://groups.google.com/d/msgid=
/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxm
> Dnm4NmWo8QWSEmLejN4fO1nAiDaBA%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
>

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/alpine.DEB.2.20.1803072039260.2814%40hadrien.
For more options, visit https://groups.google.com/d/optout.

--8323329-1036440338-1520451689=:2814--
