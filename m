Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1542408-1521027793-2-4633576333793146889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521027792; b=PqDyep3HTSALqL9On2y79WIdv+0H67m8u0CuM3QbObe5sAj
    eTzZ0WQxTWZJffadU9p77G0l32fg3hQEHyC2q55Z81Qs6aE2sz1DcEPAO1vEPgC/
    f7jv2JpDo8lbafD/M0e+Bwx+XwUYJOu+wffufrDyv9DsfmkeDppn91lVjcPnzeON
    z5+gKcIBMxJlX367MEjAJT3xTUyRBjl4IwRsv/PWG0Pya0yN3jAZQWewcXJd/yBo
    pCeU9Jh1zJ/dAAwdAHV3gagLClzToE6s7OAcJjVg6xlsnvHpoepbGHo1PPyAXOx4
    ghxj22WQvC4rnA4kLUHvs0+IhTuLSd0domoLszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521027792; bh=d
    Y5LdZArqxbZBKs13hh/imUwSNr7VBLoZuh0u4sQkuE=; b=iwVLsZoz9eWVwqNja
    mtSaYeh9jSUc/tvPBHhd6GH56WTcZCyXJ8/ZDJ8dEo4YjIBI3czixZc/3hcaCidY
    Dhj5wOtBr43JvzQD9HJ161R0GrrHH7gCbXFstXBVYqyQuu5TeQKvAs69Os4i73hQ
    5V8UCI2+bKdC5VS0WSdP1PfR5N2Mz/0H+Q+QO5qNoF+EPgGagKHtMqcdBiBTrRA2
    fepifGVjC66orXR9a8YRwOg6/nUzXqMY52FxU64jSZh7vbMKa9FYqF9csuHL/R1I
    SDUlLmQn/305Y0EzEDI9yDxycHI7YxXdmMShOX3M+M/zxkNpLILhgMTWf+bhfafm
    iw2/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 12:43:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: l4stpr0gr4m@gmail.com
Subject: Re: [PATCH] Update rf_type_definition
Message-ID: <20180314114304.GC7169@kroah.com>
References: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 justin@jvreeland.com, davem@davemloft.net, hdegoede@redhat.com,
 himanshujha199640@gmail.com, hadess@hadess.net, joe@perches.com,
 colin.king@canonical.com, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 06:23:34AM +0900, l4stpr0gr4m@gmail.com wrote:
> From: Kangmin Park <l4stpr0gr4m@gmail.com>

Your subject line should say the subsystem and driver you are modifying.
Look at the hundreds of other patches on the mailing lists for examples
of how to properly format it.

> 
> enum RT_RF_TYPE_DEFINITION on rtl8723bs/include/rtw_rf.h
> is different from enum tag_HAL_RF_Type_Definition on
> rtl8723bs/include/HalVerDef.h
> 
> So, update them to be the same reference from
> enum rf_type on rtlwifi/wifi.h which recent version.
> 
> As a result, ODM_RF_TYPE_E needs to be updated as well
> Therefore, it is updated reference from enum odm_rf_type
> on rtlwifi/phydm/phydm_pre_define.h too.
> And update some additional code to check more
> chip versions that resulted from it.
> 
> Also, fixed some space required errors and
> line over 80 characters warnings by checkpatch.pl.

When you say "also", that means you should be splitting this patch up
into multpile patches.  Please only do one-thing-per-patch.

This should be a patch series, please fix it up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
