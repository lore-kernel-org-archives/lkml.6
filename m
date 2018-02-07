Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeBGUsd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:48:33 -0500
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:32864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754591AbeBGUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:48:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amd/display: Remove extra pairs of parentheses in
 dce_calcs.c
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Tony Cheng <tony.cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
References: <20180207194928.93869-1-mka@chromium.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <d3c6dd11-7234-a427-e641-0740fae07005@amd.com>
Date: Wed, 7 Feb 2018 15:48:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207194928.93869-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CY4PR02CA0041.namprd02.prod.outlook.com (10.175.57.155) To
 MWHPR1201MB2477.namprd12.prod.outlook.com (10.172.95.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a1a889b-9dab-4259-ff58-08d56e6c21f2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2477;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;3:FE0GmR5B1kIYe9RQWsNpElMiY7RwyFHJ75n5BGXaSLUkB/h9SpLDTYrW2UESKPhgqi8ONjBspZTiF/Vk+IJk/I1Ug8s5AZ5AoaxQCEGmtBWIH8UVh79reDiGaAhDzwQpFEStcPoU6z+mE579VILoda7WJXu636pwnARFw8Q5MMkE+PSyW0klUzr9bQhK/6mExQUR+RQX3HAB4f5CjLgjs0efNEb4f7xhWh6Y824BRK5BJMqPJPBvbanzZHB5fHzA;25:YMBcSh+n7HsrLwmu4IMUUEbEVHhzp14UHFURnfgHdUdsd8aqBqU0WMSEN70fOjKKva7aZu6aljtpC1PJjUiVhKaGiN7uuYha7quSgPq4Q+SChHLSsh5SvkpUqvtJKIu5D/y9pczRjDYuicad+bTb9fNjgkcZtKV2qsEneNxgwSASivcF7UeieT7WWMt7iL1UG9YUTp+f4UaHPKRV9/5OGLRV778tgLY2n9Hjjv63tXxKprDa+4wR1iTxrLSKhDbnWp034axnCQnl4FvKDv8IxTXrbU7iYNvpZ8CNtkbyTSthb8raO4ZVxIaxfluVRyVpj+VyY5+Oe22/UTVzFPjpDA==;31:Cw5WW+YMlJwb0YOZmzmp/aZDh2xxwHlP9RsvvT6kihpkUm5FfF1dtsiyfJ37KZq8w0HSwg80O54Cue5tEOVmoQnokjHWIrevsOzeIlRFvktsE2sGllTZ6Q0Hz3lGPQgh55VBmYpHGs8TXrD5NfOB03GjZuT649fEuAGLnh3JR21IdIGLZJfOyRMKrSmF72entjLkx4kbeWzFD5BD+ZCaX3f9YJdfht+QEaDBfCk3T8Y=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;20:QpUJsFoxFVIhkZXcfDMOzMElJHd+z8EfByw2YTNxMgJeOYS3i3ysr7s8tOZy+kOEzAGgeSOEFzXHh7dFOdwIy8psv00AICnPpKwcyKXnDy1efxJffs7BZtz3As39xjTfmfIToc3rcpu5tihmFc5Ynw1IabLguWtLfSH36HU6Wcz182/sW0gfbQ16t5hpxHa4VNhHZOJ01bPfJIEcGLTaypPWjZbm/BjcW1pID/9eVmShrZ1w+N6B1pXC+fEk7HHU4Z+U6ypZRqxCBbBe1UxOpHwxI4JhBHdCQnrg3MGl3VgbtUEAR1EsD6LeqrCtVWpYkpggipdtnnZDQLa12ddhV1q86ie+S1IS5UMtZGUvc+TdIOS5TyL373GnJteViKM8WGp0XBIKUgb3Tg1E9ma/eYjy5Ga3VftZP/1U2rJPOJm4+O070c9P2hIkyOtVX8PaUzxkDm8Pzq1vQQm7BqXftqnnOTF8arEHn3h8RwvNr9DMWOHavgRaQ3VNqdvzF/+n;4:MVdS14j1ribuXuJwcQWfqGl4tN2YvJpc9KrrvHLa5H9ZSWRhpM+mdGWuhOI+Ftv2LKqG4qJLH8hkl/eOxXUk8V3db1OeeqYEoI4+c6ud3HjV+s9vPHLQV+n5faX8qDZlrxHmOakQo2nBM9VflTAL68uIxkD3BaiTSYAXW6mBgghBohhhW1dtFzLr7/rb7N7zAS9arJOadDmRJtrm2XD8RoUvuQ94ASCZZ+OQeslNUkDuPbODAKw3togncoIVTCVgkDGEl3XyOXuYC1zsEI0pr0rIoAQN84tdHOP42u1NIwTx41XySmuI69cYCyzpXCjm
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24779890523F56D919F37DF28CFC0@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR1201MB2477;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2477;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(377424004)(199004)(189003)(36756003)(31696002)(76176011)(230700001)(65806001)(97736004)(229853002)(105586002)(186003)(77096007)(26005)(31686004)(16526019)(72206003)(386003)(68736007)(59450400001)(50466002)(83506002)(86362001)(53546011)(81166006)(54906003)(65826007)(64126003)(5660300001)(2906002)(8676002)(16576012)(53936002)(110136005)(58126008)(478600001)(106356001)(316002)(3846002)(2486003)(6116002)(6246003)(52116002)(6486002)(52146003)(23676004)(90366009)(6666003)(6636002)(66066001)(4326008)(8936002)(2950100002)(47776003)(305945005)(25786009)(7736002)(81156014)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2477;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjI0Nzc7MjM6VzVDYjRoM1hGQm50RDhDLzZWUkNYVmtJ?=
 =?utf-8?B?dENLaEMzVTd0RmpGOWFjREFKZUFzUEMwTEhPM3J2NkRqY1cra3BGQm02Y0g2?=
 =?utf-8?B?SUw3YXVxa1k4alR3RDk2NVgwZ2ZiN2pEbzd2dGp5RHlLem1NOGFjaU1DajV1?=
 =?utf-8?B?aURkNnJYMisvOXo2dWNZYWxKV1RVY0NyakltWno4cTFuREsyNGVtVHdUR1NP?=
 =?utf-8?B?dzhIcWY1UTh2NmN2Q0ZncjlsbTdidjNwNEh1dytVQmJhZlgxa2htWFZ3QUw5?=
 =?utf-8?B?WHZyU1VWMGlXQVd2RFE5OFNsdlpNNzNlOVpqWUFqYnFYWndlYjhTSjcxYlBY?=
 =?utf-8?B?VTZvRnVWbzA2U2lUOG15QnRpeHFnRC9mUDRDUzBFTFk2akZjNGJGcU1XTC9G?=
 =?utf-8?B?VG9RTFNYb1Z3dmRsSWtUblE4L24veTducy91ZFFLMldDdmNZVnBhME1Gbktu?=
 =?utf-8?B?NE1yL003OGdNc2FPSEN1WmpOMUticDg0a0lRRkxrY0NmeklrQzVCSUpiNGxx?=
 =?utf-8?B?V29BcVRVbU42WVU4K0dTNmVEMEl5Q29nVHRFVGVFSUkvY3FUZFlmWDRHQ0lI?=
 =?utf-8?B?WWI5WWlPV2RuRS9wOElkdHVqVHZ6blY4WHg2MFBQODIzeXlLdzJNeXFtV1lW?=
 =?utf-8?B?Q2Y5Q2FFOWdHL0tqQ2pwUlY4MDk1VXk0cHpiZFY1ZGMwMzNvbERBdTk2dHRo?=
 =?utf-8?B?bnNIaFR0aEtwWE9oY0lVS0ZSZWdRREhDbGtxMWVxMEZSdWYycnA1QmJZZjNs?=
 =?utf-8?B?MHFaUURQckdPbUwvNy8xemNvWkVVdnR1RDlJWEtJZFZGYnBNR2RRVWE0ZDdC?=
 =?utf-8?B?SWJndkVXOEJDdDkzRUtzMEhnazlrcnNkRkt0Y0Y2d2tpanBrblNPSy9JV0J6?=
 =?utf-8?B?N20yNTFKWUxaNGpwc3pDQWorUUd5STZacXpudmNvanZiNkc5WjZXTk52a2Fw?=
 =?utf-8?B?TE9pbkJRak1DS1JiU1laUnlWbDloYllnVkRvSkg1Qk1aT3lKZExKTmIxcWhx?=
 =?utf-8?B?OHA0elFlVVoydWFDbkVKcHRHaldDS3JyVWR5cTJQd09sekttT2tPTkIzY0gy?=
 =?utf-8?B?eUNjblNBOXhjTkFIZlJSeXArQkxhYUU1UFFaczBRSFBqUzdWK2JHQVlqenBP?=
 =?utf-8?B?SDIzWGpTNWppNzlUQjNwb1dsZG12bFpiLzdSWEtHM1RpcFZBbWV4T0F0VFZ4?=
 =?utf-8?B?dVdxLzZpaXRnaC8zTjhlUHlKOXdSbysrK2hKdkJPK21IWkdabmdHWiswK2Vl?=
 =?utf-8?B?eiszTHZrTHczU1VMc3c5NTdxVlErWXNFcW45eW5rV1I5WVpYNnZnQlU0Z0Zr?=
 =?utf-8?B?VmVFMXlDaFE2YlZCek03VmcvYmk3RFdmM3ZTOTFDaEphNFZ4MUc5Yzg4RHN1?=
 =?utf-8?B?RGVVczBHbERkeGZWZ2pOdGVzemdaOVVyMFA3a3JRNWtmb0ZEbG93blRHMjRs?=
 =?utf-8?B?SmNHZEpxR0FMVE5EQ3k0SFVRMlZaZHR6azUvMU1rY1RLVmlub0w0amUwdUNy?=
 =?utf-8?B?cFcvd1NKODY3N3ZicjMyT2xtQnY5MldZb2V3Y2pmcXBjNE9vdVRWMU9OTm0y?=
 =?utf-8?B?dHAvOEVtV2pVenNxaml0TlRYd1I1ay9tU1QzL2JDekk1emFaMUZXQ3g2dXN0?=
 =?utf-8?B?YkxVVTNQTm5tN1VnWDg1SUY4czN1K0NyUUM0dTVCWGkzUGRxdDJhaDdrLzBM?=
 =?utf-8?B?eCtnK0hKWjR3aGlGenlwTklsUUtadHdnS2FUK2I5MDMwZGlnMWtHRXI0NGRU?=
 =?utf-8?B?c0FJNFlEM1FST1h2NDNCclFLRHdjaFUxdDhTRFJMOVc4YUUrdytGMkFzQmhv?=
 =?utf-8?B?K24vWnJXdDNZV3pGN0V5Z28zR0ZvNzNzT01tZWhmcjBIRTlSWWFaNmdSSnlh?=
 =?utf-8?B?bE9LM2tZaXBKZUxMRkZkdkxNSklQL25ZZmRCQWVrdUZFVmJuY1lmYXk4R3pw?=
 =?utf-8?B?dlI2dG42Q2hwbkhjQ0N0VFJtMTJNTWpxYUpaWExWdldTZWo0RGxKU2dNaGtN?=
 =?utf-8?B?dGJIcm54K2VwdnVaVzRFZzU4RmJhemRoWm9BWndBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;6:Di1UxtEXq8QR2udbWFhEVGGZtAe5BFu9ZI103gH806y0cRlMJ7RhnYK+LPIHIKpWcS3jZA8hn2onSv69ncAfi20BpELO8yQkbGhsNCXupWz6Dn2s4L6WIsUCIba9dA6fcAMMQecxbu4ceUrFUehffowAfWEtoWH56MCWXY9bPHI23j3L3+AIWxH1s86DgMwsnJsO+8J1qCQOofKskd2p6K3TNcblMXsEb542VIT0uVHDimtPi0yJB3GbMrKZZ5sH5oEOvb80b/vbPKhStS2e7NryjteY1862yAqnWpHbai/5XDtzcpzHpRXbqNPLYwNxCcohJYjRef8XsnQAQhcVHm4UpqKB40+B6RP+nG8M4DY=;5:BoGvqDymM4zRvWidmt4HPObGzET4IzG1TYCeCsd7Ap1zj2Dv+jd4GHPkTYcPvwpXx3Fky/Eyw3tIgzqzb+B+8lh5FqD5gVlRXb53erCGQ9N8ff4yZXTGmOZqST2CtX0UGdmxPa4vejBISL8lBLzjFljg0XdLWUkwIxDSbQ1sarI=;24:CL0RniW+4SyMvAihgOwO51eN/o0su54cypo/uPmeLnVw+hqF5H5whJecA4C5FqJc3c+/VR2YHY1G47CG1XyLDuiEUd74wlxJU10jbF6sBtk=;7:ABaSD0fwVVkVHRcZfHG/9ONWK5/AzEmiDr4McBZOM9iTS5jMmitI3OYpX8EEh+wpa7koGn8TjPpA/7noLDBp05y5R9TA6YxsGJvG5DLBpFn1KC/zwLQZoqyIDgb4Cd4K7HUQ1FHNItS95R8pGD6vmIfJagO+RwoF0yrqyqQkOz6VyfDaSp5PQeoyJIzrUokmromT/ziRKCMNrbMtIMI7QgxICIr67rSzsAgFN8FHnQ62CYkD3ckVwqDqMtrZDB+2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;20:jrBzZH2wBayd78uG48Jg8o4PLFpr/L+MxjL3Pp6FjUY9yiugTqd+fqt32i48eqaooFFWhShIJ1MBDFT7iNCzSA0dKgE2P35Gf0CxoFltQY5TxZO08UFqtr07IeUFOaUod+vB017IQAQrkakFsFp3ZPGBtLR1Nq0CQa5hNba/Df6rjBbdNYOJHBnw0FiRr4Ax4E+TRBf7eqMJ9HYE2N+BNeUVJJfXJH64VenkMXmcPYu5J4OfENlVrC5TkMk982Zu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 20:48:23.3982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a889b-9dab-4259-ff58-08d56e6c21f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-07 02:49 PM, Matthias Kaehlcke wrote:
> The double parentheses are not needed. Removing them fixes multiple
> warnings like this when building with clang:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:617:42:
>   error: equality comparison with extraneous parentheses
>     [-Werror,-Wparentheses-equality]
>   if ((data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling)) {
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Thanks.
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 2e11fac2a63d..bb03a9c64d5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -623,7 +623,7 @@ static void calculate_bandwidth(
>  				}
>  				else {
>  					/*graphics portrait tiling mode*/
> -					if ((data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling)) {
> +					if (data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling) {
>  						data->orthogonal_rotation[i] = 0;
>  					}
>  					else {
> @@ -634,7 +634,7 @@ static void calculate_bandwidth(
>  			else {
>  				if ((i < 4)) {
>  					/*underlay landscape tiling mode is only supported*/
> -					if ((data->underlay_micro_tile_mode == bw_def_display_micro_tiling)) {
> +					if (data->underlay_micro_tile_mode == bw_def_display_micro_tiling) {
>  						data->orthogonal_rotation[i] = 0;
>  					}
>  					else {
> @@ -643,7 +643,7 @@ static void calculate_bandwidth(
>  				}
>  				else {
>  					/*graphics landscape tiling mode*/
> -					if ((data->graphics_micro_tile_mode == bw_def_display_micro_tiling)) {
> +					if (data->graphics_micro_tile_mode == bw_def_display_micro_tiling) {
>  						data->orthogonal_rotation[i] = 0;
>  					}
>  					else {
> @@ -947,14 +947,14 @@ static void calculate_bandwidth(
>  	}
>  	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
>  		if (data->enable[i]) {
> -			if ((data->number_of_displays == 1 && data->number_of_underlay_surfaces == 0)) {
> +			if (data->number_of_displays == 1 && data->number_of_underlay_surfaces == 0) {
>  				/*set maximum chunk limit if only one graphic pipe is enabled*/
>  				data->outstanding_chunk_request_limit[i] = bw_int_to_fixed(127);
>  			}
>  			else {
>  				data->outstanding_chunk_request_limit[i] = bw_ceil2(bw_div(data->adjusted_data_buffer_size[i], data->pipe_chunk_size_in_bytes[i]), bw_int_to_fixed(1));
>  				/*clamp maximum chunk limit in the graphic display pipe*/
> -				if ((i >= 4)) {
> +				if (i >= 4) {
>  					data->outstanding_chunk_request_limit[i] = bw_max2(bw_int_to_fixed(127), data->outstanding_chunk_request_limit[i]);
>  				}
>  			}
> @@ -1337,7 +1337,7 @@ static void calculate_bandwidth(
>  	/*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
>  	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
>  		if (data->enable[i]) {
> -			if ((dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1)) {
> +			if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
>  				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(8, 10), data->total_dmifmc_urgent_latency));
>  			}
>  			else {
> @@ -1396,7 +1396,7 @@ static void calculate_bandwidth(
>  	}
>  	/*determine the number of displays with margin to switch in the v_active region*/
>  	for (k = 0; k <= maximum_number_of_surfaces - 1; k++) {
> -		if ((data->enable[k] == 1 && data->display_pstate_change_enable[k] == 1)) {
> +		if (data->enable[k] == 1 && data->display_pstate_change_enable[k] == 1) {
>  			number_of_displays_enabled_with_margin = number_of_displays_enabled_with_margin + 1;
>  		}
>  	}
> @@ -1442,7 +1442,7 @@ static void calculate_bandwidth(
>  		data->nbp_state_change_enable = bw_def_no;
>  	}
>  	/*dram clock change is possible only in vblank if all displays are aligned and have no margin*/
> -	if ((number_of_aligned_displays_with_no_margin == number_of_displays_enabled)) {
> +	if (number_of_aligned_displays_with_no_margin == number_of_displays_enabled) {
>  		nbp_state_change_enable_blank = bw_def_yes;
>  	}
>  	else {
> @@ -1470,7 +1470,7 @@ static void calculate_bandwidth(
>  		}
>  	}
>  	/*compute minimum time to read one chunk from the dmif buffer*/
> -	if ((number_of_displays_enabled > 2)) {
> +	if (number_of_displays_enabled > 2) {
>  		data->chunk_request_delay = 0;
>  	}
>  	else {
> @@ -1804,7 +1804,7 @@ static void calculate_bandwidth(
>  				data->stutter_exit_watermark[i] = bw_add(bw_sub(vbios->stutter_self_refresh_exit_latency, data->total_dmifmc_urgent_latency), data->urgent_watermark[i]);
>  				data->stutter_entry_watermark[i] = bw_add(bw_sub(bw_add(vbios->stutter_self_refresh_exit_latency, vbios->stutter_self_refresh_entry_latency), data->total_dmifmc_urgent_latency), data->urgent_watermark[i]);
>  				/*unconditionally remove black out time from the nb p_state watermark*/
> -				if ((data->display_pstate_change_enable[i] == 1)) {
> +				if (data->display_pstate_change_enable[i] == 1) {
>  					data->nbp_state_change_watermark[i] = bw_add(bw_add(vbios->nbp_state_change_latency, data->dmif_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->dram_speed_change_line_source_transfer_time[i][data->y_clk_level][data->sclk_level]));
>  				}
>  				else {
> @@ -1816,7 +1816,7 @@ static void calculate_bandwidth(
>  				data->urgent_watermark[i] = bw_add(bw_add(bw_add(bw_add(bw_add(vbios->mcifwrmc_urgent_latency, data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->line_source_transfer_time[i][data->y_clk_level][data->sclk_level])), vbios->blackout_duration), data->chunk_request_time), data->cursor_request_time);
>  				data->stutter_exit_watermark[i] = bw_int_to_fixed(0);
>  				data->stutter_entry_watermark[i] = bw_int_to_fixed(0);
> -				if ((data->display_pstate_change_enable[i] == 1)) {
> +				if (data->display_pstate_change_enable[i] == 1) {
>  					data->nbp_state_change_watermark[i] = bw_add(bw_add(vbios->nbp_state_change_latency, data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->dram_speed_change_line_source_transfer_time[i][data->y_clk_level][data->sclk_level]));
>  				}
>  				else {
> 
