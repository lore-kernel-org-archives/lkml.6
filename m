Return-Path: <outreachy-kernel+bncBAABBN464PKAKGQEMYLVI2Y@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519963959; cv=pass;
        d=google.com; s=arc-20160816;
        b=YL3I9xlrauH8/+ixZo19BuNLu9hDxekM8AWm+s/HXAJRQm/AuwamRW/RYZN/LpNHSr
         WeXAAVM1wKWWOcrOP7Mo/Y5rrADQ4iXpMBOimGjV4LEGggFLNwXLJhV/Nknoez/uGial
         ilDyHmsgc1yzOoJjdZjN/psyDMYIaUM3i7mBK0JDeVO2e3e+05MQgXzN79lpMSt3/RcV
         jx2nrss5UntUEnGzOsh+SDxxNeBRUIzm3D0Xg7Zb9bDcBK0O2xEbnO1mSB+4qoYuUXBl
         4D5DajF0nV1kxcazcQK+/xnLCdEmz/2GlfQN90AAHEG6TcYGK5tSrsgEz8Qankq6j4pr
         oijA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-filter
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=98GIv2tIaPwQLSD8FAhlg4K7UUZAG9ysaVRp0kNBKJg=;
        b=hFL+IPj3HhoYV5VmJ5FfXzeWXWYTBHF0ns5ioDsSwvKkeY9ce0JX0ApAHKS0IXvZgJ
         m/VSTlRYyQ1n1iwBtNgOULDbm1LOGQDYLjGC8M5ZHs3f1AqPWRW6S0RB1zdvCW3rI5y/
         LI9u49lSK+zLoQC1KwzFFvIa1YrabvDy+SyI1FgzJImRK6ZZnwREMGL/ofinnW8ySmAI
         gKIHtT6J/jX0hUgZLEHAw7piifb/gvmgWct2MlyxjLpDBZcNab5wz7Wu26gChjFwOgkx
         IPm16Fy10Q9QfnXB7tXWy7JMTl1ZPMkkvU+CkR6sc6hEfU1JQ+HYP4q/6cDzlzIweYFs
         rFfA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=J4IDAQno;
       arc=pass (i=2 dkim=pass dkdomain=nifty.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbaabbn464pkakgqemylvi2y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBAABBN464PKAKGQEMYLVI2Y@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=J4IDAQno;
       arc=pass (i=2 dkim=pass dkdomain=nifty.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbaabbn464pkakgqemylvi2y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBAABBN464PKAKGQEMYLVI2Y@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519963959; cv=pass;
        d=google.com; s=arc-20160816;
        b=hftQEhmtPWKrqZs6M9BXB6RppLf7U9g/WAVlNIosE5mQbKNpB2fkotQXMWZ/djBBzn
         7T4l4h6mgelFNuALCY0dZ4kz796VuFDRONONrhUI68BzxJ3gqt51S/3sTLtVE9na10Ye
         zbD8FYcTJwvA0TthjMWDJFKf8P+h6E2IxPSQOnPh/bEwenxbCMoVxzbU/wIWb585nljZ
         KsQx4enuuedcn8/WXp2yWa2+InkfI52fLK6+uRFZm3hIiGae4rGL5WflfpZkruIJ7NVL
         ulctQmnXh3hUCLQjvJi51AvgTeoK0SA9PQh9cLMK1LltvIk9lDBQZQjY17c7I4zORzEe
         LRnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-filter
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=98GIv2tIaPwQLSD8FAhlg4K7UUZAG9ysaVRp0kNBKJg=;
        b=kDVHq8B+2jzsxODLVo15qXi6xJp+sQMJb91/cBjZ3XS62AsgyNXSnQOfkOg4N3Ww5p
         Up54qeSGPlE4gN9SBlO3jWvRPAdo5SBPh6eHdJgxoPh8Iwu3OcNRsy5xVD3UBD8b6+7X
         6Tq+JpBQXwbhTyzncRpwXRbKJMd2kXZQhlmLlCCcc+xGkzfRdBq+P7xQb1KnTTevzB3t
         T0ss5fCY+Kb+IzFH0ScGlnxyp6ZRRMExpMtLiA7ws1iVRrPLPHTbVMSmX7sCIKXFrFdB
         oS/ptOjRsVl+sOrlQhCmch3Ej1hizmSyFiqJxX27gjr/wJEg2xE5H4hX45Nn2iqDDbTw
         1NeQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Z3QZAvna;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtK6TJdUnXbgsKng/AAwaobjbU/f/3kRP+ptlHGzUkN3fDOg2WZGPnf7t1RmH+/5rOPArjnpQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519917316; cv=none;
        d=google.com; s=arc-20160816;
        b=rzK9Wdo/96yyE7PYGFX/pvSJ27lB6YaSy9rkhK1osYuHlUUKsPt1HgF2kyugsYUmxv
         CTYcotSFGQUdkGEjfF7LGXJN/EA6JSYGdXL6xJJ6CB8Y4u8Uf2S/QSEjv2bdnWgSygeJ
         MLjCtSFRVwS8KesuphSQhwZEYXUEJ0aOL8jzdBDSGcWlwzYiWrumJU20va+6kUHBNyr0
         eoqcoVopCUIE7Op1zM2hDdqYtDDUgEtDowidvzwBmvN317a+CZZyGdmZwfuQbV2qZyAu
         okYIn0TM7+Sv+W6azR8Bwmugmv6P62/NR6oRPF6ajsyu2Z2RSkObqSmMWEtJmjswBD/P
         B0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=J9I35bdh+3X4D5kEXAa20L765Aj7Q7mXHBElLWTMcF8=;
        b=c0Rdxm521c76kMA827mXXuhanuXfP7Os7U94Syi6owQDRJ6xZyM6tYD6vDiSO8D4KC
         N1oLg6fIThSlD4FsG5pIyRMDuQWT+m26JwXzx5GYFlpxnWyo3o7NDQFm7rvYQkm1mX9Y
         UxEWmUpcKUsKB7BhmLxMetwLt7T65uzgRXcQWScSgZU/uju5L4SI60OSyiD4+D1Nh8gF
         R4vui0SosASUekdBOBLViJRNUKLxxtcU2eAr6c1xfNStoZIBkM8u8jSSRBxXcZKziOwS
         L79b/NJXUV2Ua4wMzccOPxo4XMmhRcJUxyd7hsaXDkRV6EQguMTV0C3+tMwx9t2t4Pwt
         0rOg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Z3QZAvna;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w21FEtjh018593
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <20180301085717.GA4508@gmail.com>
References: <20180301085717.GA4508@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Mar 2018 00:14:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZo27PwwbhMPV+KPv1u=933Vkt0-ve1HG1E2gxmnCUhA@mail.gmail.com>
Message-ID: <CAK7LNASZo27PwwbhMPV+KPv1u=933Vkt0-ve1HG1E2gxmnCUhA@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH] Coccinelle: memdup: Fix typo in
 warning messages
To: Dafna Hirschfeld <dafna3@gmail.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: yamada.masahiro@socionext.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@nifty.com header.s=dec2015msa header.b=Z3QZAvna;       spf=softfail
 (google.com: domain of transitioning yamada.masahiro@socionext.com does not
 designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593725048662035735?=
X-GMAIL-MSGID: =?utf-8?q?1593797728659305800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-01 17:57 GMT+09:00 Dafna Hirschfeld <dafna3@gmail.com>:
> Replace 'kmemdep' with 'kmemdup' in warning messages.
>
> Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---

Applied to linux-kbuild/fixes.  Thanks!


>  scripts/coccinelle/api/memdup.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
> index 1249b72..8fd6437 100644
> --- a/scripts/coccinelle/api/memdup.cocci
> +++ b/scripts/coccinelle/api/memdup.cocci
> @@ -56,10 +56,10 @@ statement S;
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdep")
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdup")
>
>  @script:python depends on report@
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING opportunity for kmemdep")
> +coccilib.report.print_report(p[0], "WARNING opportunity for kmemdup")
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CAK7LNASZo27PwwbhMPV%2BKPv1u%3D933Vkt0-ve1HG1E2gxmnCUhA%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.
