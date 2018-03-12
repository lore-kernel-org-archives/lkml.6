Return-Path: <leonard.crestez@nxp.com>
X-Google-Smtp-Source: AG47ELvqZ8uQLDFSKiCfqp5l62jK2JPHoYutHSoLW3P+UnzUjx+HnDyw7CmiST3aH0aG6nPnFC9P
ARC-Seal: i=1; a=rsa-sha256; t=1520873539; cv=none;
        d=google.com; s=arc-20160816;
        b=quvY9drpP4KgGNSyy3eDNAAWNf0pskkU1IchqrV8Lkno8w33MKschTZJ4IjlmzV2CH
         XmiFcCMxreyUnpgREfbJC6BfJ/2NCGoACs/f7S7MtiZlMpNcKDgxqQkBOv21/WdPOb8/
         sOwgIJpDW/I5uzXjHRb24D2EiIAOopAglKc314JadZNsOpO9ujMNttmNRztcsBefJpAV
         ND83KipBH5IKPoM29kDCfEpSZfHkRtnQPyEwwV31KDXCotNDPYVvcnCXrI2YyD1s0AYh
         7jclf4LUNlH1DSqDxPbL0SQAmbzH7lA3aU/78dZZ//PkxFTBOtHR18/4EnWggFwJ/0ur
         8R2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=QZJP5G7053zzChArehxYTiApb/S+PJUeKcIWir8wSUY=;
        b=Y2YFunJYoaLbRYVsBa+lJjukryZye65akqGlEsqFXg24RrrfJKF8IazfNNj4h1WBxi
         eNfvRGnupiXX2yHULBHQiAEq5xHQOhQhbegPPPQvbUfT5T0B993db4rk63oQ7psxFwe5
         InZFb+KkiGpLiPoaLZ/iRSXi7oE2CRiTbwamXCLLknCFqVLXuJwO6/GfvteFnCQYBCgs
         TqHdR26wyQC0XKXfXEgZTrRwF4D542+1CnV+jQB++PZtsNS6iHWYRKoM5gLtvWeEc1Fd
         21KAoLjKK4zN+N8Jv7E5KBweofEyBuYi0YfghrGjyccKbaG0HwwBDT9Z6xFaKGc5YK0e
         DNbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leonard.crestez@nxp.com designates 104.47.40.52 as permitted sender) smtp.mailfrom=leonard.crestez@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leonard.crestez@nxp.com designates 104.47.40.52 as permitted sender) smtp.mailfrom=leonard.crestez@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Message-ID: <1520873532.28521.18.camel@nxp.com>
Subject: Re: a Heisenbug tale (was: Re: arm crypto .S_shipped files
 sometimes get rebuilt randomly)
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, "Masahiro
 Yamada" <yamada.masahiro@socionext.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Date: Mon, 12 Mar 2018 18:52:12 +0200
In-Reply-To: <CAKv+Gu8z2aMeGEi5Jbi+CBpbyMAmxHnZCO+URrVFgb33tddppw@mail.gmail.com>
References: <1520450729.13685.19.camel@nxp.com>
	 <c4b2ac3a-9f6f-9985-c7a3-f758c13e7b73@rasmusvillemoes.dk>
	 <CAKv+Gu8z2aMeGEi5Jbi+CBpbyMAmxHnZCO+URrVFgb33tddppw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131653471383778050;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(377424004)(50226002)(8936002)(6246003)(36756003)(110136005)(54906003)(105606002)(26826003)(229853002)(68736007)(230700001)(5660300001)(498600001)(2950100002)(97736004)(8676002)(76176011)(2906002)(104016004)(103116003)(86362001)(575784001)(81166006)(81156014)(4326008)(53546011)(316002)(956003)(50466002)(305945005)(106466001)(336012)(6346003)(26005)(5820100001)(47776003)(356003)(23676004)(53936002)(99106002)(142923001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3363;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD027;1:JdkYXHrdMTxOIT0HQWPqHN+00ifWJeQGbYkmj4sEcy/uDtQ3aXXuusdqQOegA74mujix1oeSTfuRY0kiGOAM0TVc2LiUN+BtSULE1dreuxQa/ggkjZDlpkhKgJvjhCjs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c6222f2-c126-466f-3040-08d588399db9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB3363;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3363;3:YLIdrYYPrEk3yxmJZTSUB6GoopslL6tfDwogdSIeUMz5PM7v+D7zr6c7jInTo8KGd+p0Ytwru9UfdqAH1+V7pw2zM3kH4u1Q4AKwjRPd6lAEPaoUgYhXyeGZp66xIbTVtB8/Q12qVpc3TH2NOimvr68x9YNA9jWakFowj7BV3sNZ8CNaNg3U9JrkFASRz7byA+BJZmDzJt3kWEBKo/ircRgiLFXBn0vdJfkhEl36dNXUdsr3cGA2G0H8b9p18ESYwXLbwzCS6e/siEMAMP6+HM+ASlyVM2HBrvBu2wNLTaSor1nNEqAAbOWvuXg1z6rhu1V2RZVbKn/lLQO9RnwqNaryFkMZkqQTtg+IGsvPrWc=;25:PWWSENWt8qlE8bRwObV3yh/XHwuYA8LBGwvW76gPn6KdoBUrtoG4XzxktjgJJ2IpjYEmXAOfCrduprqdwF/oun+NUqjCV0JYWdpXquX3Eg08eK0ODfhmIJgo4TVJhArU5e4NyzGrc+wSnMHDGkGWNPseLToq2fAtCIx8fA4Dp0DCqQDgwTcxOtkvC7QF8BFKNqvEYjmd5+whNJsc/Y2Tg3GGhxWZzbucRESe8wMZZuDAElAhfUiIt7urS9fXK3oBEPbiIjhJoMPCYuFDCWFZU5NKNFNA4mR6o76xdljvBSwpTByYsTWg9EJLIb62jcQP4lZDpzC0YHX51xX7v6MKcA==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3363:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3363;31:T2PdtZwVQUxAeCdFxo1eN5IIN/OgNVUelIenbX+F0b49qeXykwbWp5N96bcTYT+dv9kCugT3dW8jaTpsNAwhX5DfL/oCXQpoQKhGZDz/1EXx3m43SUPJy0KPmSqD9ZDVfbh/OSD5e4X9Nbc21KxUYUY6u1oa/K331175aDvgsPGqb+Bni1zRkplyWTUhdUA4TecOfkdxowKztG0USKkDTePQNjcbXcRyFYoDfaTSlvk=;4:g11rBzy5q8dSGMd1YIImcnE7vSIq3m29lVbrqruz96+yRXuDi1tRB6XQUSnu8yt/iDy6bLp2vY9GAY/NL/z4Ckl02yhcePNlf1IHKUNw/TMMvY9TbDtNEwbKuDi2roZuU+Or6vASa4416lnGtnclEybP4rnLQS1KYme5KW6BeCTIAAru6O3w/T3FOJ2bwS0BFZCAwwqjTyYsB7YZ3Qc+HFZb3TMzv5BmiZXV/hG+OfT9xZD3tGVBygvegU6xR+SavOntz760E/7MhdnfDUmBOQ==
X-Microsoft-Antispam-PRVS: <BN6PR03MB336388F4651626BDF56A967CEED30@BN6PR03MB3363.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6096035)(20161123563025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123556025)(201708071742011);SRVR:BN6PR03MB3363;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB3363;
X-Forefront-PRVS: 06098A2863
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMzYzOzIzOlRhT3RHS25LcSt1L1AvNnE3MkVla3lxOFdn?=
 =?utf-8?B?VnJyN2NuNmxEbWNhbmZDKzdEWTZ5V1g3di9GZTlUb0hNbkdNZjVEdDZpdlJC?=
 =?utf-8?B?Y21YRCt5QXVseXhXYXVrMXYwRzFBMyt5cStLZWVldkY5KzU0aHJOMnJjL0RD?=
 =?utf-8?B?c1QxVG9aU1B3c3VBNjR6ZTZBM0t1dWtzN3ViMm1ZbG9yN3JVZTNzQ2o1NFZY?=
 =?utf-8?B?QWVPMHJNcnF1YytKTkFobU9Jam5SN2huWk5tME1VN2s1dmV5VXYxZ01RNFNr?=
 =?utf-8?B?M1BIUHFRZ2JPcDJyQUNvd0hQQXpTU1N4RWxYb3dFMWl6bUZpMC9ER3J5ZjZ3?=
 =?utf-8?B?c29JYXAwNjlWL3JKSWlEWkxZOWg5SHhoMzFzc0MyYlFrcXZObTBXMll3bFJz?=
 =?utf-8?B?bUlPVHJvMVVRVmRjU2R4a1hwSXVqc0NhMW9mRDl1VmxTVWZvZWF6SXVKY3lX?=
 =?utf-8?B?RFJqek1GbHFDdmt0ZHVFQXFCWmdlTjFnUko4VjlSR2JGcGNOK0w5Qk1zamdO?=
 =?utf-8?B?UkZmbEhSWWtQUWxtMXpCOFkrVkJDSWVLSDg0WmVpbVBRdW85TWpPbDlxMGlB?=
 =?utf-8?B?MVVyRlRlN3BUWEFvc2Q2N1hRVGZ2RURpNVNLc3Q1dXdiQ1VwV0czWWlOOHll?=
 =?utf-8?B?bVZETWRLRVIxeVA3M0dLSjVCV0htWmw3MmpRYnh0ZWoxRmFlaU1Qc1VRUS9C?=
 =?utf-8?B?T3ZTUFZYeEFQOG1FS1VkMjNqWEJkQ3pKcUErOHd6bERQUXB1bWtHankxZU9O?=
 =?utf-8?B?djZTU0pnUWtNZXd2RmhCM2NWTlJ3eDRYM2xEcGZWanBUTytwaFdpU2dWcC9Y?=
 =?utf-8?B?V2xwUmNFZjZpYWhEdzg0ZSsycDR3MTFIa2w1SExpQjFnamhzK01VTEcwamc4?=
 =?utf-8?B?b0llWmpEYllxL0hKL3YwU0ZTUHFqbFJMWlU4dWRQREZJRG9GcXAvTU5iV0t0?=
 =?utf-8?B?VFpKT0ZyQ2NPQU5OVGJvR0pNalEvamc5dEM2SXNhOS9NUVgwTThTdTFESThr?=
 =?utf-8?B?ZDJndXhLQU1NR2NsOS9Da0tQOGpxUlZmS25YckgyZEJXdHRWVFg1NGx0SExL?=
 =?utf-8?B?N3E0Vjg5Q1lDMkgzZEI4ZTcwNXRwRGZTNEtzSkgzNnBOcldOdHNXbWprRm4y?=
 =?utf-8?B?bk5tWWVSRWcySkhrTC9LMHoxc1AvRTlyZjduZXhERkdiQ3NGcW52N0RsQ2lF?=
 =?utf-8?B?ZHUzQ0lYODhJb3pmbVd5VUZQNVRCRCsxODdJc1ZKQUN0QjUyTHZJVGVyTzhi?=
 =?utf-8?B?azVkZjJLMU1KZ084NzdFR1ZGNDZPcHkxSHFiTDA0UUFJRjExYVV6cWxJM3lN?=
 =?utf-8?B?c2I1MGpsajZUMUtWY2NvV3ZFaEZXZWZwYjh1ZEI0T2JVdXIrYWgxUzdKSEoy?=
 =?utf-8?B?aU9XN1lUdWw0MFJJTFJSeHM4c0xjVkw3bjVGNFA3OTRDSEVqL2NnTjczOFZG?=
 =?utf-8?B?dG8xdVhSNkoxcU1mZ0svN25OcGo1NS9veVVjTSt0VXFCTU5JZHpYMjg5ZW1s?=
 =?utf-8?B?MHcxRXdCOXF1eEtQdFRPSUFMUHBjbWw1UnNjcU5TOUk5RkdOVXNISGUzRUxo?=
 =?utf-8?B?RURxRVFTTlE2dkpaTmRkbm05KzI1TkJlTitTZFluOUJRdkNvZU5BY0IyMlJm?=
 =?utf-8?B?ZzhDZGJSblZCUHJpNHRyTGZwRzhGYXBtcnFRc1h5VlpDd2M2MHdUcEhGcStL?=
 =?utf-8?Q?SdJ/OPlBfF82cFGvkSTvv7uIPkvBNfXK55m/JJ7?=
X-Microsoft-Antispam-Message-Info: 5atO5tO6Lzw2akSnm6pDeJ+SDFv0rumczS651BjBEiPL4ee6QSj9/sf3HauSwNx3Fd8cYDWYRaK5rKlSDbGHClTsLvoWvJJA+RAlNWwSsIusswzJbCp4nBR7D3KgXEsn8EYKdJrxk9Q1bxrJWLsUq/zA8c5/7Np8pgriMd/0y2RqmACqb/lJDT5LRpOjGD1d
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3363;6:mPr6FGTAhlfxir+tPjHNjnlRy/xD3jKs12+UxuOIl5uq6AmGPNg5vpSDes8eFphshRZXJzaVnSH+JpexQslIXna4L1cAMbga35uK0fqrlrvIfzMRG7NTGLBECDXVtEc2FGf7SSiVyFGxv7B+AiSVbzpvWQMP2pm2lFQL3DJJCem1E4V2+DG4l02aAY893McENVxIm/MfVIJdpLPLpNDl+NAoLVwILtr9IRpMAKZfu7R92nmpqWU+Z2DN5xgIp2nzhHy60ulvea1seciXoBvw1GGyl4U4ZOhen2gtqwVkQRQ57l80QD4qWE83C4e5B8ysPnGzfR02kSMZ+3jJZ32/7y8+vjNfZ8gOZwP4xgeqfGc=;5:STspf7BsGGfwkgf2UJ2HSMv9KO+0DSKHuZNPR0hVfNJDJgEaa+i5ylZK0gvUEoablKybTJwzhWRw3kPrWX4ofwnTxqk20DYgkm/kaICr0S3Iak5lT/j7osAOl8qQzlEZVeD4+keBzj9eiUoB+SsGoParBbAx1gDg4D+gEOyn1sk=;24:sVkSekibII96lsY7tQUUOZqzq4iFlK5fO5EZFMoqmeyCFQogMouSXm+5uoKJvLuQnRcq53LgCKmM7WC2RfpUlCkNMOdwnYS2vwyH4k5+OiQ=;7:w1NQ9HDPHIenCR+WIUHAt35G8wIUlqI7KbkDGC6dymjM7eUMqVchFCrw5w6j9+t99gxCtqHEXMTLGYlm/3rVllUeHuyxPGFCBYw4XIVP2m/ZPTvhqZTsBC86T0XevKTF69DlgLIwGljB/icY/7rSqtN9/JL/SLMFEnxOiL3M6zIXsIKwSWsF9FEQqiJrB8eRWPtr9LNN/ob09ZaHLzbed1HTJi4NRwFBuA08xj/6YU7lTpbY7wLMGa3fyXCIythK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 16:52:18.2062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6222f2-c126-466f-3040-08d588399db9
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3363
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1594751492398502751?=
X-GMAIL-MSGID: =?utf-8?q?1594751492398502751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-09 at 09:45 +0000, Ard Biesheuvel wrote:
> On 8 March 2018 at 23:19, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > On 2018-03-07 20:25, Leonard Crestez wrote:

> > > I am using a toolchain with a broken/old version of perl which doesn't
> > > include integer.pm and I noticed it triggers occasional build failures
> > > on arch/arm64/crypto/sha512-core.S_shipped. Workarounds are easy, but
> > > if the purpose of the .S_shipped is to avoid the need to have all
> > > dependencies on the build machine then something went wrong?

> > About a year ago, I debugged a very similar problem for a customer. The
> > build system (an OpenEmbedded clone) did something like
> > 
> > (1) git clone -n ...
> > (2) git checkout -q $somerev
> > (3) make foo_config
> > (4) make vmlinux
> > (5) make LOADADDR=0x1234 uImage
> > (6) make modules
> > ...
> > 
> > The symptoms, when the bug appeared, was that the kernel was built with
> > some version string "4.5.6-01234-g0abcdef", but the modules (both the
> > native kernel modules and those built externally using the linux-dev
> > package) ended up in /lib/modules/4.5.6-01234-g0abcdef-dirty.

> I had no idea that _shipped files were causing issues like this, and
> AFAICT, this is not specific to this use case in arch/arm/crypto,
> right?
> 
> Russell, would you mind if we removed the _shipped.S file here and
> just assume that perl is available?

It would be good for the fix to get into stable branches so that
downstreams don't each have to invent workarounds. Isn't it much easier
to do this with an #ifdef REGENERATE_ARM_CRYPTO_ASM? It might even be a
requirement for getting into stable.

The _shipped.S stuff can be removed later just for upstream.

--
Regards,
Leonard
