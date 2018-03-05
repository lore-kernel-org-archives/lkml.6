Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELu648AKsnw63h7gf2jHj5o9BRdwEWfAmQcvVqMy2GaydnrHrFGlCffekZMjrx3QhSk5NmO+
ARC-Seal: i=1; a=rsa-sha256; t=1520278178; cv=none;
        d=google.com; s=arc-20160816;
        b=0tL8cqRo9/jc0P4JFrA17Tb1PZugyM219rUaQyCZoCHWdVtl1uBBAK+/lape0iaf4G
         Czhu7GwIyIlXNbccBwFyDm1Rcuc6EEWvXiYgVBZ7RzEYcylhxEzJjv3rZFNnYlzWKdDW
         IJD+5MfiwZ/ADMNx+36QYw6LqDD/NMhmJ1t9rBM/EwwoPfaQhASyqpq19sfzg1JV++2b
         1uj62ts3YS1t3I8pHxay2nug+67qmVteuLdSLdl8FMv8PWZ4t2Mg29Ke2iwJEgdyPw1J
         lIDQgBEqdRk/nCUmtAfDJf6wt+yT1b/Iie71Esaz3L+mU66HnMKl8Crv2tkAtfqCW+eN
         NM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=MLHXS5wMlAHO9sVj4Eq9JzjQntYsZh6QqmWRw5j4OUM=;
        b=dm7xtIVBJI+Pbu8dUISfa1PeD0yCHnTBQz8whdNeTwvqh4SG0z6LnE6dQB/NblynUs
         lqh+YnhTkA89Lt6OrR3zG7I2VbMbips+EtjprRHrYrOztzjAsSv1aV08FlX9n2JlzPMC
         vmYH2SUv496cBhqxxRZga7WDeAvpjpAsXgeAg0L65Sswt6Mxr2P42dNAQUleFmZ5CnKR
         K59Cz5TAhyq+cLl2WHVEzT6aIMy+RW6U/jo5BAI7QMny1G6iTkJs/A0B6cvTOs13Y2PH
         zL2oXgTDTTsVD79KS3a1lpbocT925hj2Jm8pmynfn298OI2kI6RqgFzYxt4k04KgPFNv
         +TTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.210 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.210 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3867:3871:3872:4321:5007:7576:7653:7903:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12438:12555:12683:12740:12760:12895:13439:14181:14659:14721:21080:21221:21433:21627:21740:30022:30054:30070:30091,0,RBL:109.168.25.226:@perches.com:.lbl8.mailshell.net-62.8.122.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: fifth01_199b7b6968e3a
X-Filterd-Recvd-Size: 4905
Message-ID: <1520278173.25605.16.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: add check for tag Co-Developed-by
From: Joe Perches <joe@perches.com>
To: "Tobin C. Harding" <me@tobin.cc>, Andrew Morton
 <akpm@linux-foundation.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski
 <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 05 Mar 2018 11:29:33 -0800
In-Reply-To: <1520222301-11874-2-git-send-email-me@tobin.cc>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
	 <1520222301-11874-2-git-send-email-me@tobin.cc>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068638523514417?=
X-GMAIL-MSGID: =?utf-8?q?1594127212146440656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 14:58 +1100, Tobin C. Harding wrote:
> From: Joe Perches <joe@perches.com>

I still think this "Co-Developed-by" stuff is unnecessary.

> Recently signature tag Co-Developed-by was added to the
> kernel (Documentation/process/5.Posting.rst). checkpatch.pl doesn't know
> about it yet. All prior tags used all lowercase characters except for first
> character. Checks for this format had to be re-worked to allow for the
> new tag.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  scripts/checkpatch.pl | 58 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3d4040322ae1..fbe2ae2d035f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -461,16 +461,18 @@ our $logFunctions = qr{(?x:
>  	seq_vprintf|seq_printf|seq_puts
>  )};
>  
> -our $signature_tags = qr{(?xi:
> -	Signed-off-by:|
> -	Acked-by:|
> -	Tested-by:|
> -	Reviewed-by:|
> -	Reported-by:|
> -	Suggested-by:|
> -	To:|
> -	Cc:
> -)};
> +our @valid_signatures = (
> +	"Signed-off-by:",
> +	"Acked-by:",
> +	"Tested-by:",
> +	"Reviewed-by:",
> +	"Reported-by:",
> +	"Suggested-by:",
> +	"Co-Developed-by:",
> +	"To:",
> +	"Cc:"
> +);
> +my $signature_tags = "(?x:" . join('|', @valid_signatures) . ")";
>  
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
> @@ -2193,6 +2195,17 @@ sub pos_last_openparen {
>  	return length(expand_tabs(substr($line, 0, $last_openparen))) + 1;
>  }
>  
> +sub get_preferred_sign_off {
> +	my ($sign_off) = @_;
> +
> +	foreach my $sig (@valid_signatures) {
> +		if (lc($sign_off) eq lc($sig)) {
> +			return $sig;
> +		}
> +	}
> +	return "";
> +}
> +
>  sub process {
>  	my $filename = shift;
>  
> @@ -2499,35 +2512,34 @@ sub process {
>  			my $sign_off = $2;
>  			my $space_after = $3;
>  			my $email = $4;
> -			my $ucfirst_sign_off = ucfirst(lc($sign_off));
> +			my $preferred_sign_off = ucfirst(lc($sign_off));
>  
> -			if ($sign_off !~ /$signature_tags/) {
> +			if ($sign_off !~ /$signature_tags/i) {
>  				WARN("BAD_SIGN_OFF",
>  				     "Non-standard signature: $sign_off\n" . $herecurr);
> -			}
> -			if (defined $space_before && $space_before ne "") {
> +			} elsif ($sign_off !~ /$signature_tags/) {
> +				$preferred_sign_off = get_preferred_sign_off($sign_off);
>  				if (WARN("BAD_SIGN_OFF",
> -					 "Do not use whitespace before $ucfirst_sign_off\n" . $herecurr) &&
> +					 "'$preferred_sign_off' is the preferred signature form\n" . $herecurr) &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =
> -					    "$ucfirst_sign_off $email";
> +					$fixed[$fixlinenr] = "$preferred_sign_off $email";
>  				}
>  			}
> -			if ($sign_off =~ /-by:$/i && $sign_off ne $ucfirst_sign_off) {
> +			if (defined $space_before && $space_before ne "") {
>  				if (WARN("BAD_SIGN_OFF",
> -					 "'$ucfirst_sign_off' is the preferred signature form\n" . $herecurr) &&
> +					 "Do not use whitespace before $preferred_sign_off\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] =
> -					    "$ucfirst_sign_off $email";
> +					    "$preferred_sign_off $email";
>  				}
> -
>  			}
> +
>  			if (!defined $space_after || $space_after ne " ") {
>  				if (WARN("BAD_SIGN_OFF",
> -					 "Use a single space after $ucfirst_sign_off\n" . $herecurr) &&
> +					 "Use a single space after $preferred_sign_off\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] =
> -					    "$ucfirst_sign_off $email";
> +					    "$preferred_sign_off $email";
>  				}
>  			}
>  
