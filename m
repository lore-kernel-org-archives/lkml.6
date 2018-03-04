Return-Path: <outreachy-kernel+bncBCUJ7YGL3QFBBJ7O57KAKGQE2RJVEMA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520170791; cv=pass;
        d=google.com; s=arc-20160816;
        b=pzH+AIiVr+Ctc9/xlYjQiXTGMGFfLlrObbXzKkWNhcd/StUTIcxEDLU5aw+U64XQD8
         YnA/7mdfiq+k081Z/exQgdryBguAS1O7ED3juLjlf2yVd2904hPxyHVli0GNka6jssaO
         wm58Ce0xeSpBshlUKBcfzIQD1eZnr0Dtg16LXZBY6MKi8prwBbJ5PrzdP/HgElvsmGfm
         cgBatRRkVj6JVJcVnxwMhE2Kap5+VEeyZ2ylVTCir1IiBPPLah4POpT2FmO8AJmQIQv8
         TsuIgHnG9P/0XWTEyFGH4HLMysXDDEA9jzgxJD4va4lF6d++2qzMDMqhRahkOqoln2H7
         Kf1Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=UP5CsWQZM/xYsF2XLM6uSSN/8HbktNlhr0WJ9fLg61s=;
        b=thj+8n0g2IvS0PTx80pt6zIo+Ukiv2XvhmCJ4UHmxRhteWPtDk9n/o0kKWiy1sEM6C
         cSac+pQEV1Me6VnccQe7B7oZJIP8UdMNnTsXRT4fXZUk59UrlaxJ4/HRBeup7VzwPF0I
         L1w7DnK3oxtZ2dx7/7Wd4mBANkLrb11uNueIKjvdJpcRVRL9f93Fne9zrrRaj3k7lMf9
         yzmcjypSJKvOoVo8/rgmwVBpCppgvhy8fx/zDZkwmlkEZAC95yOffT6ByPHPUCv42fJH
         lJSAFqeQdRe0gQX8zGIHCWz371bjWx+shA/xQJ0WtcPtk506X9KK/6pmW6569seQUkLA
         T00w==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=PefCkS1v;
       arc=pass (i=2 spf=pass spfdomain=linuxfoundation.org);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuj7ygl3qfbbj7o57kakgqe2rjvema@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUJ7YGL3QFBBJ7O57KAKGQE2RJVEMA@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=PefCkS1v;
       arc=pass (i=2 spf=pass spfdomain=linuxfoundation.org);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuj7ygl3qfbbj7o57kakgqe2rjvema@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUJ7YGL3QFBBJ7O57KAKGQE2RJVEMA@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520170791; cv=pass;
        d=google.com; s=arc-20160816;
        b=PiSJ9gwgumyyUTBPGao3YgrTCmWa4EKogBFslx9KEMu1U1DaJ74n0FDB+iSenK0ci5
         5/qhoQjkGq8/NtmjJiPI5xXlf0m368hdouATXaq6snX3vl9K58QuHLHr15G8Y6wMMqP6
         sSgVrxHRp6s7rQxkAxkViZkJTntAwozaRjLVuvELpuaek3Vafjew6Dkz5hd6CkWlY4Iy
         lLM6OH0kNHG7+9tDGqCzk73LFtMjlCGC9WV+JcYrY6GQAdKgF/rxP72HWGe3+QpPgujy
         ggO/eymnS7wNm0hpAefB8zqrFrw97fPGd6O0sOfs+zEmOQYsPUUoxxPgfaPvYLnBCx/E
         umAA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=UP5CsWQZM/xYsF2XLM6uSSN/8HbktNlhr0WJ9fLg61s=;
        b=rxaWzuH88GHaeArALP32TX0svJy9Vr3zesDGJapjLaq/YXhfYAJw3xrE6Cr8CPMIJn
         w7eVqTKql4ZfSRgBDnuPvpOAeoibtbVaPzyj3eBOAFGdRA4gKSIQBXbsuPGcwwJQunzS
         +eTYK+lGVwQIB7Fk8WAUdzkVyiQ8h88r6rtyKWc71Y/fqm7fXJd8DIRLjE+ePyyCxhqQ
         br0a1TwZlsDUFLGAa3ZQ0NY0fRJPiRsds+5ylrpbLfaX+Q9WgEQ0bXo6BfWaCLfpfQrM
         tppP9xSKugxKAY+S9RKSKlxgcaD6WHX0v2En8URpEauZJqrQ4cEsL3bzFKPHyKVbmGRI
         s6cw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELs72U4KwH61/xItpbmbL0Fm8XUe2zHWAgjdD1dAkPzx+vly0Z8+MIkY4yoArb9/+gzm5Me3mA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520170790; cv=none;
        d=google.com; s=arc-20160816;
        b=rk9AC9QZcl3Ux/H817EmoBWJgAg5yJAQUr22ZKl+57xdfd2f8oAh8on4JQjQ8AeNA+
         Gs3p6gAn76qTZ5KOOcKYHveL0yMVizgN+yF9BNR+5KOIo1zoKQlKiStWo0m253mQ23dL
         dpK7N5PYpkekwikNZ1NcupYMKBQTO+gfgaofmn+mwmP2Yx41kQdl2BaDMwiec5T82Rzn
         AWmVFQJM4Dtltu26BJKy+M2A8CHRkQbmeIv+8OyCKAVaGVpWmdqXKfCZ217YHkmwHT+b
         VvkiRx1RndtOl3ihuXXTXhNnio6RAufnq5xuRKw7HkYygsYlvvZwCjbngwZSjjfskiK6
         t2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zY5JhxLFYZZqb/10mPC0xbrL5I+smqCxB4UFoRbewQg=;
        b=QNXEWi8i5EEebo+gnC5w7ADpQBkVE5kV26dkQXbwKwYKyXWOaYWqxXf3+2YiuU5rfH
         4U+feao9LbQbekTgrLxBUKTmKuyp0i0dIQVTY+WHE1bumVCrSt1okjlNHd9zH3zgR5VL
         dGNvr3TQTPdVHW2Fcf1qNLMKJ7tpnKqpzxzkOFNbWSHKdOcvSBxxu/x0PWiveIYgyB52
         qR6ijZyHaHbe3eQnDHSJ43o+zSS53h1MjXgSd/mwkc4/cUF/yfMpajPz1GjtJocYG8st
         /lrFOrCdyzZ5dwEoI/0TC9WPs3Koi0SEp3hd9U/N7vYyPt9/mJHDfITJFjqsWxFRXaXX
         rLIw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sun, 4 Mar 2018 14:29:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH] staging: ipx: Replace printk() with
 appropriate pr_*() macro
Message-ID: <20180304132901.GA4222@kroah.com>
References: <20180304085935.GA20591@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180304085935.GA20591@seema-Inspiron-15-3567>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Original-Sender: gregkh@linuxfoundation.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of gregkh@linuxfoundation.org designates 140.211.169.12
 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593997003912323739?=
X-GMAIL-MSGID: =?utf-8?q?1594014608172625610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 04, 2018 at 02:29:35PM +0530, Arushi Singhal wrote:
> Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
> Replace printks having a log level with the appropriate pr_*() macros.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/ipx/af_ipx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
> index d21a9d1..27f4461 100644
> --- a/drivers/staging/ipx/af_ipx.c
> +++ b/drivers/staging/ipx/af_ipx.c
> @@ -744,7 +744,7 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
>  			intrfc->if_netnum = cb->ipx_source_net;
>  			ipxitf_add_local_route(intrfc);
>  		} else {
> -			printk(KERN_WARNING "IPX: Network number collision "
> +			pr_warn("IPX: Network number collision "

It is a driver, so it would be best to use dev_warn() or even better
yet, net_warn().  Please try to make that change instead.

thanks,

greg k-h

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180304132901.GA4222%40kroah.com.
For more options, visit https://groups.google.com/d/optout.
